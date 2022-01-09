import 'dart:typed_data';

import 'package:mobx/mobx.dart';
import 'package:todo_mobx/data/models/login/src/user_model.dart';
import 'package:todo_mobx/data/repositories/profile_repository.dart';
import 'package:todo_mobx/presentation/logic/profile/src/profile_image_state.dart';
import 'package:todo_mobx/presentation/logic/profile/src/profile_user_data_state.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  final ProfileRepository _profileRepository;

  _ProfileStore(this._profileRepository);

  @observable
  ProfileImageState profileImageState = const ProfileImageState.loading(0.0);

  @observable
  UserModel? userData;

  @observable
  ProfileUserDataState profileUserDataState =
      const ProfileUserDataState.noData();

  @action
  Future<void> getProfileImage() async {
    try {
      profileImageState = const ProfileImageState.loading(0.0);
      final profileImageBytes = await _profileRepository.getUserProfileImage(_imageProgressCallback);
      profileImageState = ProfileImageState.loaded(profileImageBytes);
    } catch (e, s) {
      print('e: $e, s: $s');
      profileImageState =
          const ProfileImageState.error('Error in laoding profile image');
    }
  }

  @action
  Future<void> uploadProfileImage(
      String profileImagePath, Uint8List bytes) async {
    try {
      profileImageState = const ProfileImageState.loading(0.0);
      await _profileRepository.uploadProfileImage(
        profileImagePath,
        _imageProgressCallback,
      );
      profileImageState = ProfileImageState.loaded(bytes);
    } catch (e, s) {
      print('e: $e, s: $s');
      profileImageState =
          const ProfileImageState.error('Error in laoding profile image');
    }
  }

  @action
  void _imageProgressCallback(int count, int total) {
    final double progressPercent = count.toDouble() / total.toDouble();
    print('count : $count , total : $total , percent : $progressPercent');
    profileImageState = ProfileImageState.loading(progressPercent);
  }

  @action
  Future<void> getUserData() async {
    try {
      profileUserDataState = const ProfileUserDataState.loading();
      final profileResponse = await _profileRepository.getUserData();
      userData = UserModel(
          id: profileResponse.id,
          firstName: profileResponse.name,
          email: profileResponse.email,
          age: profileResponse.age);
      profileUserDataState = ProfileUserDataState.loaded(userData!);
    } catch (e, s) {
      print('e: $e, s: $s');
      profileUserDataState = const ProfileUserDataState.error(
          'Error in loading data from server!');
    }
  }
}
