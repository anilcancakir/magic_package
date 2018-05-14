import 'package:magic/magic.dart';

Map<String, dynamic> authConfig = {
  /// Default authentication guard
  'default': 'basic',

  /// Authentication guards
  'guards': {
    'basic': new BasicGuard()
  }
};