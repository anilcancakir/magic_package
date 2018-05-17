import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:magic/magic.dart';

class User extends Model implements Authenticatable {
  static String endpoint = 'users';

  String id;
  String name;
  String gender;
  DateTime birthday;
  String bio;

  @override
  getAuthIdentifier() {
    return this.id;
  }

  @override
  void setAttributes(Map<String, dynamic> data) {
    this.id = data['id'];
    this.name = data['name'];
    this.gender = data['gender'];
    this.birthday = data['birthday'];
    this.bio = data['bio'];
  }

  @override
  getPrimaryKey() {
    return this.id;
  }
}

abstract class Model {
  static String endpoint;
  BaseDataReceiver provider;
  void setAttributes(Map<String, dynamic> data);
  dynamic getPrimaryKey();
}

class ApiDataReceiver extends BaseDataReceiver {
  final String _endpoint;

  ApiDataReceiver(this._endpoint);

  @override
  Future<dynamic> create(Map<String, dynamic> data) async {
    return await this._toMapFromResponse(
      apiClient().put(this._makeUrl(), body: data)
    );
  }

  @override
  Future<bool> delete(identifier) async {
    try {
      await apiClient().delete(
        this._makeUrl(identifier: identifier)
      );
    } catch (e) {
      return false;
    }

    return true;
  }

  @override
  Future<dynamic> get(identifier, {Map<String, dynamic> queries}) async {
    return await this._toMapFromResponse(
      apiClient().put(this._makeUrl())
    );
  }

  @override
  Future<List<dynamic>> index({Map<String, dynamic> queries}) async {
    return await this._toMapFromResponse(
      apiClient().get(
        this._makeUrl(queries: queries)
      )
    );
  }

  @override
  Future<dynamic> update(identifier, Map<String, dynamic> data) async {
    return await this._toMapFromResponse(
      apiClient().post(
        this._makeUrl(identifier: identifier), body: data
      )
    );
  }

  String _makeUrl({String identifier, Map<String, dynamic> queries}) {
    String url = config('api.url') + this._endpoint;
    if (identifier != null) {
      url += '/' + identifier;
    }

    if (queries != null) {
      Uri uri = Uri.parse(url);
      uri.replace(queryParameters: queries);
      return url.toString();
    }

    return url;
  }

  Future<dynamic> _toMapFromResponse(Future<http.Response> request) async {
    final response = await request;
    return json.decode(response.body);
  }
}