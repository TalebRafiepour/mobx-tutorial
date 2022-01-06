import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todo_mobx/data/models/login/src/login_response.dart';
import 'package:todo_mobx/services/http_client/index.dart';

class UserApi {
  final HttpClient _httpClient;
  final String loginPath = '/user/login';

  UserApi(this._httpClient);

  Future<LoginResponse> login(String email,String password) async {
    final data = {
      'email': email,
      'password': password,
    };
    final dataJson = jsonEncode(data);
    final Response<dynamic> response = await _httpClient.post(path: loginPath,data: dataJson);
    print('result: ${response.data}, type: ${response.runtimeType}');
    return LoginResponse.fromJson(response.data);
  }
}
