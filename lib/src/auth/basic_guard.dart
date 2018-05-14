import 'dart:async';

import '../contracts/auth/authenticatable.dart';
import '../contracts/auth/guard.dart';

class BasicGuard extends Guard {
  @override
  Future<bool> attempt(Map<String, dynamic> credentials, {bool remember}) {
    return new Future.delayed(new Duration(seconds: 1), () {
      return true;
    });
  }

  @override
  bool check() {
    return false;
  }

  @override
  bool guest() {
    return true;
  }

  @override
  id() {
    return null;
  }

  @override
  void logout() {

  }

  @override
  Authenticatable user() {
    return null;
  }
}