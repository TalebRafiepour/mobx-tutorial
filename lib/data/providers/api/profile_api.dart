import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_mobx/data/models/profile/profile_response.dart';
import 'package:todo_mobx/services/http_client/index.dart';

class ProfileApi {
  final HttpClient _httpClient;

  ProfileApi(this._httpClient);

  Future<ProfileResponse> getUserData(String token) async {
    final Response<dynamic> response = await _httpClient.get(
      path: '/user/me',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return ProfileResponse.fromJson(response.data);
  }

  Future<void> logOut(String token) async {
    return _httpClient.post(
      path: '/user/logout',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<ProfileResponse> editUserData(
      String token, String email, String name, int age) async {
    Map<String, dynamic> data = {
      'email': email,
      'name': name,
      'age': age,
    };
    final Response<dynamic> response = await _httpClient.put(
      path: '/user/me',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
      data: jsonEncode(data),
    );
    return ProfileResponse.fromJson(response.data['data']);
  }

  Future<Uint8List?> getUserProfileImage(String token, String userId,
      [ProgressCallback? onReceiveProgress]) async {
    final tempDir = await getTemporaryDirectory();
    const String profileImageName = 'profile.png';

    final profileImage = File(tempDir.path + '/' + profileImageName);
    if (await profileImage.exists()) {
      await profileImage.delete();
      await profileImage.create();
    } else {
      await profileImage.create();
    }

    final Response<dynamic> response = await _httpClient.download(
      path: '/user/$userId/avatar',
      savePath: profileImage.path,
      progressCallback: onReceiveProgress,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final profileImageBytes = await profileImage.readAsBytes();
    return profileImageBytes;
  }

  Future<bool> uploadProfileImage(String token, String profileImagePath,
      [ProgressCallback? onSendProgress]) async {
    await _httpClient.post(
      path: '/user/me/avatar',
      onSendProgress: onSendProgress,
      data: FormData.fromMap({
        'avatar': await MultipartFile.fromFile(profileImagePath),
      }),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return true;
  }
}
