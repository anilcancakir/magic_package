import 'package:app/routes/global_routes.dart';
import 'package:fluro/fluro.dart';
import 'package:magic/magic.dart';

class RouterServiceProvider extends ServiceProvider {
  @override
  void boot(Magic magic) {
    // TODO: implement boot
  }

  @override
  void register(Magic magic) {
    this._registerGlobalRoutes(magic.router);
  }

  /// Register the global routes.
  void _registerGlobalRoutes(Router router) {
    new GlobalRoutes().register(router);
  }
}