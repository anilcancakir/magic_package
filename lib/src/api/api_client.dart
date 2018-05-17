import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../helpers.dart';

class ApiClient extends http.BaseClient {
  final RegExp _urlRegExp = new RegExp(r'^(?:(?:http|https|ftp):\/\/)');
  final String _baseUri;
  final http.Client _inner;
  
  ApiClient(String baseUri)
  : this._inner = new http.Client()
  , this._baseUri = baseUri.endsWith('/') ? baseUri : baseUri + '/';
  
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Set json
    request.headers['Accept'] = 'application/json';

    if (auth().check()) {
      request.headers['Authorization'] = await auth().getBearerToken();
    }

    return this._inner.send(request);
  }

  @override
  Future<http.Response> delete(url, {Map<String, String> headers}) {
    return this._inner.delete(this._setUrl(url), headers: headers);
  }

  @override
  Future<http.Response> patch(url, {Map<String, String> headers, body, Encoding encoding}) {
    return this._inner.patch(this._setUrl(url), headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> put(url, {Map<String, String> headers, body, Encoding encoding}) {
    return this._inner.put(this._setUrl(url), headers: headers, body: body, encoding: encoding);
  }

  @override
  Future<http.Response> post(url, {Map<String, String> headers, body, Encoding encoding}) {
    return this._inner.post(this._setUrl(url), headers: body, encoding: encoding);
  }

  @override
  Future<http.Response> get(url, {Map<String, String> headers}) {
    return this._inner.get(this._setUrl(url), headers: headers);
  }
  
  String _setUrl(String url) {
    if (this._urlRegExp.hasMatch(url)) {
      return url;
    }

    return this._baseUri + (url.startsWith('/') ? url.substring(1) : url);
  }
}