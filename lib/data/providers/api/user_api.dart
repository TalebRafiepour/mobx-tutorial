import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  Future<LoginResponse> loginWithGoogle(GoogleSignInAccount user) async {
    final data = {
      'user_id': user.id,
      'email': user.email,
      'display_name': user.displayName,
      'photo_url': user.photoUrl,
    };
    final dataJson = jsonEncode(data);
    final Response<dynamic> response =
        await _httpClient.post(path: '/loginWithGoogle', data: dataJson);
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
        await _httpClient.post(path: '/user/register', data: dataJson);
    print('result: ${response.data}, type: ${response.runtimeType} status code: ${response.statusCode}');
    return RegisterResponse.fromJson(response.data);
  }
}
