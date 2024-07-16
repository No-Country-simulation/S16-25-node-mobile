import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserMode {
  const UserModel._();
  const factory UserModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'age') int? age,
    @JsonKey(name: 'telephone') String? telephone,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
    @JsonKey(name: 'role') String? role,
    @JsonKey(name: 'animals_adopted') List<String>? token,
    @JsonKey(name: 'address') String? animals,
    @JsonKey(name: 'image') String? profile,
  }) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModeFromJson(json);
}
