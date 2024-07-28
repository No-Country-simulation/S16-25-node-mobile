import 'package:app_patitas/home/models/animal_model.dart';
import 'package:app_patitas/home/models/publicaciones_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'datarefugio_model.freezed.dart';
part 'datarefugio_model.g.dart';

@freezed
class DataRefugioModel with _$DataRefugioModel {
  const DataRefugioModel._();
  const factory DataRefugioModel({
    @JsonKey(name: 'id') String? id, // Cambiado de int? a String?
    @JsonKey(name: 'nombre') String? nombre,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'correo') String? correo,
    @JsonKey(name: 'telefono') String? telefono,
    @JsonKey(name: 'gerente') String? gerente,
    @JsonKey(name: 'animales') List<Map<String, dynamic>>? animales,
    @JsonKey(name: 'publicaciones') List<Map<String, dynamic>>? publicaciones,
    //@JsonKey(name: 'token_user') String? token_user,
  }) = _DataRefugioModel;

  factory DataRefugioModel.fromJson(Map<String, dynamic> json) =>
      _$DataRefugioModelFromJson(json);
}
