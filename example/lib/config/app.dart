import 'package:app/app/providers/api_service_provider.dart';
import 'package:app/app/providers/auth_service_provider.dart';
import 'package:app/app/providers/data_service_provider.dart';
import 'package:app/app/providers/router_service_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:magic/magic.dart';

Map<String, dynamic> appConfig = {
  /// Application Name
  'name': 'Magic',

  /// Application Environment
  'env': 'production',

  /// Application Locale Configuration
  'locale': new Locale('en', 'US'),

  'supportedLocales': [
    new Locale('en', 'US')
  ],

  'providers': <ServiceProvider>[
    new RouterServiceProvider(),
    new AuthServiceProvider(),
    new ApiServiceProvider(),
    new DataServiceProvider()
  ]
};