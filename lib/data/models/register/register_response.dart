
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_mobx/data/models/login/src/user_model.dart';

part 'register_response.freezed.dart';
part 'register_response.g.dart';

@freezed
class RegisterResponse with _$RegisterResponse {
  factory RegisterResponse({
    required String token,
    required UserModel user,
}) = _RegisterResponse;

  factory RegisterResponse.fromJson(dynamic json) => _$RegisterResponseFromJson(json);
}