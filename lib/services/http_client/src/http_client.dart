import 'package:dio/dio.dart';

class HttpClient {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://api-nodejs-todolist.herokuapp.com'));

  static final HttpClient _singleton = HttpClient._();

  HttpClient._();

  factory HttpClient() => _singleton;

  Future<dynamic> post(String path, [dynamic data]) {
    return _dio.post(path, data: data);
  }

  void get() {}

  void put() {}

  void delete() {}
}
