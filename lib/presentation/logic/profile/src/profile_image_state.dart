import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_image_state.freezed.dart';

@freezed
class ProfileImageState with _$ProfileImageState {
  const factory ProfileImageState.loading(double progress) = Loading;

  const factory ProfileImageState.error(String message) = Error;

  const factory ProfileImageState.loaded(dynamic bytes) = Loaded;
}
