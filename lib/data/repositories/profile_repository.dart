import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:todo_mobx/data/models/profile/profile_response.dart';
import 'package:todo_mobx/data/providers/api/profile_api.dart';
import 'package:todo_mobx/data/providers/storage/secure/secure_storage.dart';

class ProfileRepository {
  final ProfileApi _profileApi;
  final SecureStorage _secureStorage;

  ProfileRepository(this._profileApi, this._secureStorage);

  Future<void> logOut() async {
    final token = await _secureStorage.getUserToken() ?? '';
    await _profileApi.logOut(token);
    await _secureStorage.clean();
  }

  Future<ProfileResponse> getUserData() async {
    var token = await _secureStorage.getUserToken();
    if (token == null) throw Exception('token user is null');
    return await _profileApi.getUserData(token);
  }

  Future<ProfileResponse> putUserData(
      String email, String name, int age) async {
    var token = await _secureStorage.getUserToken();
    if (token == null) throw Exception('token user is null');
    return await _profileApi.editUserData(token, email, name, age);
  }

  Future<Uint8List?> getUserProfileImage(
      [ProgressCallback? onSendProgress]) async {
    final token = await _secureStorage.getUserToken();
    final userData = await _secureStorage.getUserData();

    if (token == null || userData == null) {
      throw Exception('token or user data is null');
    }

    return _profileApi.getUserProfileImage(token, userData.id, onSendProgress);
  }

  Future<void> uploadProfileImage(String profileImagePath,
      [ProgressCallback? onSendProgress]) async {
    var token = await _secureStorage.getUserToken();
    if (token == null) throw Exception('token user is null');

    await _profileApi.uploadProfileImage(
        token, profileImagePath, onSendProgress);
  }
}
