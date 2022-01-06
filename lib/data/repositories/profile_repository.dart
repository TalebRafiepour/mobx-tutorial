import 'dart:typed_data';

import 'package:todo_mobx/data/models/profile/profile_response.dart';
import 'package:todo_mobx/data/providers/api/profile_api.dart';
import 'package:todo_mobx/data/providers/storage/secure_storage.dart';

class ProfileRepository {
  final ProfileApi _profileApi;
  final SecureStorage _secureStorage;

  ProfileRepository(this._profileApi, this._secureStorage);

  Future<ProfileResponse> getUserData() async {
    var token = await _secureStorage.getUserToken();
    if (token == null) throw Exception('token user is null');
    return await _profileApi.getUserData(token);
  }

  Future<Uint8List?> getUserProfileImage() async {
    final token = await _secureStorage.getUserToken();
    final userData = await _secureStorage.getUserData();

    if (token == null || userData == null) {
      throw Exception('token or user data is null');
    }

    return _profileApi.getUserProfileImage(token, userData.id);
  }

  Future<void> uploadProfileImage(String profileImagePath) async {
    var token = await _secureStorage.getUserToken();
    if (token == null) throw Exception('token user is null');

    await _profileApi.uploadProfileImage(token, profileImagePath);
  }
}
