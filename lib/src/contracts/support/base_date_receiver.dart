import 'dart:async';

abstract class BaseDataReceiver {
  Future<List<dynamic>> index({Map<String, dynamic> queries});
  Future<dynamic> get(dynamic identifier, {Map<String, dynamic> queries});
  Future<dynamic> update(dynamic identifier, Map<String, dynamic> data);
  Future<dynamic> create(Map<String, dynamic> data);
  Future<bool> delete(dynamic identifier);
}