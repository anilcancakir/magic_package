import 'package:flutter/widgets.dart';

typedef Widget RouterCallback(Map<String, String> params);

class MagicRouter {
  /// The currently dispatched route.
  String _current = '/';

  void add(String path, RouterCallback callback) {}
}