import 'dart:convert';

import 'package:todo_mobx/data/providers/api/user_api.dart';
import 'package:todo_mobx/data/providers/storage/secure/secure_storage.dart';

class LoginRepository {
  final UserApi _userApi;
  final SecureStorage _secureStorage;

  LoginRepository(this._userApi, this._secureStorage);

  Future<bool> loginUser(String email, String password) async {
    var loginResponse = await _userApi.login(email, password);
    await _secureStorage.saveUserToken(loginResponse.token);
    await _secureStorage.saveUserData(jsonEncode(loginResponse.user.toJson()));
    return true;
  }
}
