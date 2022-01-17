import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todo_mobx/data/models/login/src/login_response.dart';
import 'package:todo_mobx/data/models/register/register_response.dart';
import 'package:todo_mobx/services/http_client/index.dart';

class UserApi {
  final HttpClient _httpClient;
  final String loginPath = '/user/login';

  UserApi(this._httpClient);

  Future<LoginResponse> login(String email, String password) async {
    final data = {
      'email': email,
      'password': password,
    };
    final dataJson = jsonEncode(data);
    final Response<dynamic> response =
        await _httpClient.post(path: loginPath, data: dataJson);
    print('result: ${response.data}, type: ${response.runtimeType}');
    return LoginResponse.fromJson(response.data);
  }

  Future<RegisterResponse> register(
      String name, String email, String password, String age) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
      'age': age
    };
    final dataJson = jsonEncode(data);
    final Response<dynamic> response =
        await _httpClient.post(path: 'user/register', data: dataJson);
    print('result: ${response.data}, type: ${response.runtimeType}');
    return RegisterResponse.fromJson(response.data);
  }
}
