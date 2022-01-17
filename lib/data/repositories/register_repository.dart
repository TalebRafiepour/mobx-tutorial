import 'dart:convert';

import 'package:todo_mobx/data/providers/api/user_api.dart';
import 'package:todo_mobx/data/providers/storage/secure_storage.dart';

class RegisterRepository {
  final UserApi _userApi;
  final SecureStorage _secureStorage;

  RegisterRepository(this._userApi, this._secureStorage);

  Future<bool> registerUser(
      String name, String email, String password, String age) async {
    var registerResponse = await _userApi.register(name, email, password, age);
    await _secureStorage.saveUserToken(registerResponse.token);
    await _secureStorage
        .saveUserData(jsonEncode(registerResponse.user.toJson()));
    return true;
  }
}
