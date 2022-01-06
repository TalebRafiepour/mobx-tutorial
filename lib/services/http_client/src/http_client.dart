import 'package:dio/dio.dart';

class HttpClient {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://api-nodejs-todolist.herokuapp.com'));

  static final HttpClient _singleton = HttpClient._();

  HttpClient._();

  factory HttpClient() => _singleton;

  Future<dynamic> post({required String path, dynamic data, Options? options}) {
    return _dio.post(path, data: data, options: options);
  }

  Future<dynamic> put({required String path, dynamic data, Options? options}) {
    return _dio.put(path, data: data, options: options);
  }

  Future<Response<dynamic>> get(
      {required String path, Options? options}) async {
    return _dio.get(path, options: options);
  }

  void delete() {}
}
