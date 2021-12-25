import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todo_mobx/services/http_client/index.dart';

class UserApi {
  final HttpClient _httpClient;
  final String loginPath = '/user/login';

  UserApi(this._httpClient);

  Future<bool> login(String email,String password) async {
    final data = {
      'email': email,
      'password': password,
    };
    final dataJson = jsonEncode(data);
    final Response<dynamic> response = await _httpClient.post(loginPath, dataJson);
    print('result: ${response.data}, type: ${response.runtimeType}');
    var result = response.data;
    var token = result['token'];
    //read json and save it in storage
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }
}
