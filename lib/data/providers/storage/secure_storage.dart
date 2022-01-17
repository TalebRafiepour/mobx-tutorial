import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_mobx/data/models/login/src/user_model.dart';

class SecureStorage {
  final _flutterSecureStorage = const FlutterSecureStorage();
  final _userTokenKey = 'userTokenKey';
  final _userKey = 'userKey';

  static final _instance = SecureStorage._();

  SecureStorage._();

  factory SecureStorage() => _instance;

  Future<void> clean() {
    return _flutterSecureStorage.deleteAll();
  }

  Future<void> saveUserToken(String token) async {
    await _flutterSecureStorage.write(key: _userTokenKey, value: token);
  }

  Future<String?> getUserToken() async {
    final token = await _flutterSecureStorage.read(key: _userTokenKey);
    return token;
  }

  Future<bool> isUserLogin() async {
    final token = await _flutterSecureStorage.read(key: _userTokenKey);
    return token != null;
  }

  Future<void> saveUserData(String userData) async {
    await _flutterSecureStorage.write(key: _userKey, value: userData);
  }

  Future<UserModel?> getUserData() async {
    final userData = await _flutterSecureStorage.read(key: _userKey);
    if (userData != null) {
      final userDataJson = jsonDecode(userData);
      return UserModel.fromJson(userDataJson);
    } else {
      return null;
    }
  }
}
