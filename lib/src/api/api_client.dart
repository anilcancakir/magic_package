import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../helpers.dart';

class ApiClient {
  final RegExp _urlRegExp = new RegExp(r'^(?:(?:http|https|ftp):\/\/)');
  final String _baseUri;
  final http.Client _inner;
  
  ApiClient(String baseUri)
  : this._inner = new http.Client()
  , this._baseUri = baseUri.endsWith('/') ? baseUri : baseUri + '/';

  Future<http.Response> delete(url, {Map<String, String> headers}) async {
    return this._inner.delete(this._setUrl(url), headers: await this._setHeaders(headers));
  }

  Future<http.Response> patch(url, {Map<String, String> headers, body, Encoding encoding}) async {
    return this._inner.patch(this._setUrl(url), headers: await this._setHeaders(headers), body: body, encoding: encoding);
  }

  Future<http.Response> put(url, {Map<String, String> headers, body, Encoding encoding}) async {
    return this._inner.put(this._setUrl(url), headers: await this._setHeaders(headers), body: body, encoding: encoding);
  }

  Future<http.Response> post(url, {Map<String, String> headers, body, Encoding encoding}) async {
    return this._inner.post(this._setUrl(url), headers: await this._setHeaders(headers), body: body, encoding: encoding);
  }

  Future<http.Response> get(url, {Map<String, String> headers}) async {
    return this._inner.get(this._setUrl(url), headers: await this._setHeaders(headers));
  }
  
  String _setUrl(String url) {
    if (this._urlRegExp.hasMatch(url)) {
      return url;
    }

    return this._baseUri + (url.startsWith('/') ? url.substring(1) : url);
  }

  Future<Map<String, String>> _setHeaders(Map<String, String> headers) async {
    if (headers == null) {
      headers = new Map<String, String>();
    }

    headers['Accept'] = 'application/json';

    if (auth().check()) {
      headers['Authorization'] = await auth().getBearerToken();
    }

    return headers;
  }
}