import 'package:freezed_annotation/freezed_annotation.dart';

part 'refugio_model.freezed.dart';
part 'refugio_model.g.dart';

@freezed
class RefugioModel with _$RefugioModel {
  const RefugioModel._();
  const factory RefugioModel({
    @JsonKey(name: 'id') String? id, // Cambiado de int? a String?
    @JsonKey(name: 'nombre') String? nombre,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'correo') String? correo,
    @JsonKey(name: 'telefono') String? telefono,
    @JsonKey(name: 'gerente') String? gerente,
    @JsonKey(name: 'animales') List<String>? animales,
    @JsonKey(name: 'publicaciones') List<String>? publicaciones,
    //@JsonKey(name: 'token_user') String? token_user,
  }) = _RefugioModel;

  factory RefugioModel.fromJson(Map<String, dynamic> json) =>
      _$RefugioModelFromJson(json);
}
