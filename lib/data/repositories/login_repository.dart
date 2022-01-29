import 'dart:convert';

import 'package:google_sign_in/google_sign_in.dart';
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

  Future<bool> loginWithGoogle(GoogleSignInAccount user) async {
    var loginResponse = await _userApi.loginWithGoogle(user);
    await _secureStorage.saveUserToken(loginResponse.token);
    await _secureStorage.saveUserData(jsonEncode(loginResponse.user.toJson()));
    return true;
  }
}
