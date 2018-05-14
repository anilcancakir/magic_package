import 'dart:async';

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
  BaseDataProvider provider;
  void setAttributes(Map<String, dynamic> data);
  dynamic getPrimaryKey();
}

abstract class BaseDataProvider {
  String endpoint;

  Future<dynamic> index({Map<String, dynamic> queries});

  Future<dynamic> get(dynamic identifier, {Map<String, dynamic> queries});

  Future<dynamic> update(dynamic identifier, Map<String, dynamic> data);

  Future<dynamic> create(Map<String, dynamic> data);

  Future<bool> delete(dynamic identifier);
}

class DataProvider extends BaseDataProvider {
  @override
  Future create(Map<String, dynamic> data) {
    // TODO: implement create
  }

  @override
  Future<bool> delete(identifier) {
    // TODO: implement delete
  }

  @override
  Future get(identifier, {Map<String, dynamic> queries}) {
    // TODO: implement get
  }

  @override
  Future index({Map<String, dynamic> queries}) {
    // TODO: implement index
  }

  @override
  Future update(identifier, Map<String, dynamic> data) {
    // TODO: implement update
  }

}