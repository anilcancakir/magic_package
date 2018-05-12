import 'package:app/app/providers/router_service_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:magic/magic.dart';

Map<String, dynamic> config = {
  /// Application Name
  'name': 'Magic',

  /// Application Environment
  'env': 'production',

  /// Application Locale Configuration
  'locale': new Locale('en'),

  'supportedLocales': [
    new Locale('en')
  ],

  'providers': <ServiceProvider>[
    new RouterServiceProvider()
  ]
};