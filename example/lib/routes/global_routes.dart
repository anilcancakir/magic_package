import 'package:app/app/controllers/global_controller.dart';
import 'package:fluro/fluro.dart';
import 'package:magic/magic.dart';

class GlobalRoutes extends BaseRoutes {
  @override
  void register(Router router) {
    router.define('/', handler: new Handler(handlerFunc: (_, __) {
      return new GlobalController().index();
    }));
  }
}