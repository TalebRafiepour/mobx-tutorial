import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
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

  Future<ProfileResponse> editUserData(
      String token, Map<String, dynamic> data) async {
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

  Future<Uint8List?> getUserProfileImage(String token, String userId) async {
    final Response<dynamic> response = await _httpClient.get(
      path: '/user/$userId/avatar',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return response.data as Uint8List?;
  }

  Future<bool> uploadProfileImage(String token, String profileImagePath) async {
    final Response<dynamic> response = await _httpClient.post(
      path: '/me/avatar',
      data: FormData.fromMap({
        'avatar': MultipartFile.fromString(profileImagePath,
            filename: profileImagePath.split('/').last)
      }),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final result = response.data['success'];
    return result;
  }
}
