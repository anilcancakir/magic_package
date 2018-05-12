import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../config/magic_config.dart';
import '../routing/base_routes.dart';
import '../support/service_provider.dart';

typedef Object MagicConcreteCallback(Magic magic);
typedef void VoidCallback();

class Magic {
  /// The current globally available magic (if any).
  static Magic _instance;

  /// Set the globally available instance of the magic.
  static Magic getInstance() {
    if (Magic._instance == null) {
      Magic._instance = new Magic();
    }

    return _instance;
  }

  /// The magic's bindings.
  Map<Type, Object> _bindings = new Map<Type, Object>();

  /// Current magic's environment.
  String _environment = 'local';

  /// All of the registered service providers.
  List<ServiceProvider> _serviceProviders = new List<ServiceProvider>();

  /// Indicates if the magic has "booted".
  bool _booted = false;

  /// Create a new magic application instance.
  Magic() {
    this._registerCoreBindings();
  }

  /// Register a shared binding in the magic.
  void singleton<T>(MagicConcreteCallback concrete) {
    this._bindings[T] = concrete(this);
  }

  /// Resolve the given type from the magic.
  T make<T>() {
    return this._bindings[T];
  }

  /// Get or check the current application environment.
  String environment() {
    return this._environment;
  }

  /// Register a service provider with the application.
  void register(ServiceProvider serviceProvider) {
    serviceProvider.register(this);

    if (this._booted) {
      this._bootRegisterProvider(serviceProvider);
    }

    this._serviceProviders.add(serviceProvider);
  }

  /// Boot the magic's service providers.
  void boot({
    String name,
    String env,
    String locale,
    Map<String, dynamic> config
  }) {
    if (this._booted) {
      return;
    }

    // Set the configurations of app
    config.forEach((String key, dynamic value) => this._setConfigIfNotNull('app.$key', value));
    this._setConfigIfNotNull('app.name', name);
    this._setConfigIfNotNull('app.env', env);
    this._setConfigIfNotNull('app.locale', locale);

    // Register the application providers.
    List<ServiceProvider> providers = this.make<MagicConfig>().get('app.providers');
    if (providers != null) {
      providers.forEach((ServiceProvider serviceProvider) => this.register(serviceProvider));
    }

    // Boot the registered providers.
    this._serviceProviders.forEach(this._bootRegisterProvider);

    this.router.printTree();

    // Run the app!
    runApp(new MaterialApp(
      title: this.make<MagicConfig>().get('app.name'),
      locale: this.make<MagicConfig>().get('app.locale'),
      onGenerateRoute: this.make<Router>().generator,
      supportedLocales: this.make<MagicConfig>().get('app.supportedLocales'),
    ));
  }

  /// Set the magic's environment.
  void setEnvironment(String environment ) {
    _environment = environment;
  }

  /// The helper for router.
  Router get router {
    return this.make<Router>();
  }

  /// Register the base routes.
  void registerRoutes(List<BaseRoutes> routes) {
    routes.forEach((BaseRoutes routes) {
      routes.register(this.router);
    });
  }

  /// Boot the given service provider.
  void _bootRegisterProvider(ServiceProvider serviceProvider) {
    serviceProvider.boot(this);
  }

  /// Register the core bindings in the magic.
  void _registerCoreBindings() {
    this.singleton<MagicConfig>((_) => new MagicConfig());
    this.singleton<Router>((_) => new Router());
  }

  /// Set the config variable if the value is not null.
  void _setConfigIfNotNull(String key, dynamic value) {
    if (value != null) {
      this.make<MagicConfig>().set(key, value);
    }
  }
}