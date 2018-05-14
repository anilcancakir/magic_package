import 'dart:async';

abstract class Guard {
  /// Determine if the current user is authenticated.
  bool check();

  /// Determine if the current user is a guest.
  bool guest();

  /// Get the currently authenticated user.
  dynamic user();

  /// Get the ID for the currently authenticated user.
  dynamic id();

  /// Attempt to authenticate a user using the given credentials.
  Future<bool> attempt(Map<String, dynamic> credentials, {bool remember});

  /// Log the user out of the application.
  void logout();
}