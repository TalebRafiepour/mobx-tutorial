import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

@freezed
class ProfileResponse with _$ProfileResponse {

  factory ProfileResponse({
    required int age,
    @JsonKey(name: '_id') required String id,
    required String name,
    required String email,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(dynamic json) => _$ProfileResponseFromJson(json);
}