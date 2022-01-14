import 'package:dio/dio.dart';

class HttpClient {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://api-nodejs-todolist.herokuapp.com',receiveTimeout: 2*60*1000));

  static final HttpClient _singleton = HttpClient._();

  HttpClient._();

  factory HttpClient() => _singleton;

  Future<dynamic> post(
      {required String path,
      dynamic data,
      Options? options,
      ProgressCallback? onSendProgress}) {
    return _dio.post(path,
        data: data, options: options, onSendProgress: onSendProgress);
  }

  Future<dynamic> put({required String path, dynamic data, Options? options}) {
    return _dio.put(path, data: data, options: options);
  }

  Future<Response<dynamic>> get(
      {required String path, Options? options}) async {
    return _dio.get(path, options: options);
  }

  Future<Response<dynamic>> download(
      {required String path,
      required savePath,
      Options? options,
      ProgressCallback? progressCallback}) async {
    return _dio.download(path, savePath,
        options: options, onReceiveProgress: progressCallback);
  }

  void delete() {}
}
