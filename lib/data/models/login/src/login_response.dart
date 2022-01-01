
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todo_mobx/data/models/login/src/user_model.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  factory LoginResponse({
    required String token,
    required UserModel user,
}) = _LoginResponse;

  factory LoginResponse.fromJson(dynamic json) => _$LoginResponseFromJson(json);
}