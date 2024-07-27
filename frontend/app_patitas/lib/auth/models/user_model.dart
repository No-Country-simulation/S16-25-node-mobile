import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const UserModel._();
  const factory UserModel({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'nombre') String? name,
    @JsonKey(name: 'telefono') String? telephone,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'password') String? password,
    @JsonKey(name: 'rol') String? role,
    @JsonKey(name: 'direccion') String? animals,
    @JsonKey(name: 'image') String? profile,
    @JsonKey(name: 'tipoDocumento') String? typodocument,
    //@JsonKey(name: 'token_user') String? token_user,
    @JsonKey(name: 'documento') String? document,
  }) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
