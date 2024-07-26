import 'package:freezed_annotation/freezed_annotation.dart';

part 'publicaciones_model.freezed.dart';
part 'publicaciones_model.g.dart';

@freezed
class PublicacionesModel with _$PublicacionesModel {
  const PublicacionesModel._();
  const factory PublicacionesModel({
    @JsonKey(name: 'id') String? id, // Cambiado de int? a String?
    @JsonKey(name: 'titulo') String? titulo,
    @JsonKey(name: 'texto') String? texto,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'refugio') String? refugio,
    //@JsonKey(name: 'token_user') String? token_user,
  }) = _PublicacionesModel;

  factory PublicacionesModel.fromJson(Map<String, dynamic> json) =>
      _$PublicacionesModelFromJson(json);
}
