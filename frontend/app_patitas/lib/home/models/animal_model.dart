import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'animal_model.freezed.dart';
part 'animal_model.g.dart';

@freezed
class AnimalModel with _$AnimalModel {
  const AnimalModel._();
  const factory AnimalModel({
    @JsonKey(name: 'id') String? id, // Cambiado de int? a String?
    @JsonKey(name: 'nombre') String? nombre,
    @JsonKey(name: 'especie') String? especie,
    @JsonKey(name: 'edad') int? edad,
    @JsonKey(name: 'peso') int? peso,
    @JsonKey(name: 'image') String? image,
    @JsonKey(name: 'estado') String? estado,
    //@JsonKey(name: 'token_user') String? token_user,
  }) = _AnimalModel;

  factory AnimalModel.fromJson(Map<String, dynamic> json) =>
      _$AnimalModelFromJson(json);
}
