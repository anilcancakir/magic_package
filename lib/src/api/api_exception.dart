import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiException implements Exception {
  int _code = 500;
  String _message = 'Server error';
  Map<String, dynamic> _errors;

  ApiException(http.Response response) {
    if (response != null) {
      this._code = response.statusCode;

      Map<String, dynamic> data = json.decode(response.body);
      print(data);

      if (data != null) {
        if (data.containsKey('message')) {
          this._message = data['message'];
        }

        if (data.containsKey('errors')) {
          this._errors = data['errors'];
        }
      }
    }
  }

  Map<String, dynamic> get errors => _errors;
  String get message => _message;
  int get code => _code;

  @override
  String toString() {
    return 'ApiException{_code: $_code, _message: $_message, _errors: $_errors}';
  }

  static bool hasError(http.Response response) {
    if (response != null) {
      if (response.statusCode >= 400) return true;

      Map<String, dynamic> data = json.decode(response.body);

      if (data != null) {
        if (data.containsKey('error')) return true;
        if (data.containsKey('errors')) return true;
        if (data.containsKey('success') && data['success'] == false) return true;
      }
    }

    return false;
  }
}