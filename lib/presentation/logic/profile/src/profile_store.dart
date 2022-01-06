import 'dart:typed_data';

import 'package:mobx/mobx.dart';
import 'package:todo_mobx/data/models/login/src/user_model.dart';
import 'package:todo_mobx/data/repositories/profile_repository.dart';
import 'package:todo_mobx/presentation/logic/profile/src/profile_image_state.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  final ProfileRepository _profileRepository;

  _ProfileStore(this._profileRepository);

  @observable
  ProfileImageState profileImageState = const ProfileImageState.loading();

  @observable
  UserModel? userData;

  @action
  Future<void> getProfileImage() async {
    try {
      profileImageState = const ProfileImageState.loading();
      final profileImageBytes = await _profileRepository.getUserProfileImage();
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
      profileImageState = const ProfileImageState.loading();
      await _profileRepository.uploadProfileImage(profileImagePath);
      profileImageState = ProfileImageState.loaded(bytes);
    } catch (e, s) {
      print('e: $e, s: $s');
      profileImageState =
          const ProfileImageState.error('Error in laoding profile image');
    }
  }

  @action
  Future<void> getUserData() async {
    try {
      final profileResponse = await _profileRepository.getUserData();
      userData = UserModel(
          id: profileResponse.id,
          firstName: profileResponse.name,
          email: profileResponse.email,
          age: profileResponse.age);
    } catch (e, s) {
      print('e: $e, s: $s');
    }
  }
}
