import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {

  factory UserModel({
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'name') required String firstName,
    required String email,
    required int age,
  }) = _UserModel;

  factory UserModel.fromJson(dynamic json) => _$UserModelFromJson(json);
}
