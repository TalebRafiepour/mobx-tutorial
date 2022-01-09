import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_mobx/data/models/login/src/user_model.dart';

part 'profile_user_data_state.freezed.dart';

@freezed
class ProfileUserDataState with _$ProfileUserDataState {
  const factory ProfileUserDataState.noData() = NoData;
  const factory ProfileUserDataState.loading() = Loading;
  const factory ProfileUserDataState.loaded(UserModel userModel) = Loaded;
  const factory ProfileUserDataState.error(String message) = Error;
}