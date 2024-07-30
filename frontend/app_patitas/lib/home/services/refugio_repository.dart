import 'dart:convert';
import 'dart:io';

import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/home/models/datarefugio_model.dart';
import 'package:app_patitas/home/models/refugio_model.dart';
import 'package:dio/dio.dart';

class RefugiosRepository {
  final String urlPostRefugio = '${Const.baseUrl}refugio/';
  final String urlPost = '${Const.baseUrl}post/';
  final String urlCreateAnimal = '${Const.baseUrl}animal/';
  final Dio dio = Dio();

  Future<List<RefugioModel>?> getRefugios() async {
    final token = await Const.getStorage.read(key: "token") ?? "";
    try {
      final Response response = await dio.get(
        urlPostRefugio,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;

      final List<dynamic>? refugiosList =
          responseData['refugios'] as List<dynamic>?;

      if (refugiosList != null) {
        return refugiosList
            .map((json) => RefugioModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        print('No se encontró la lista de refugios en la respuesta.');
        return null;
      }
    } catch (e) {
      print("Error al obtener refugios: $e");
      return null;
    }
  }

  Future<DataRefugioModel?> getDetallesRefugio(String id) async {
    final token = await Const.getStorage.read(key: "token") ?? "";

    try {
      final Response response = await dio.get(
        "$urlPostRefugio/$id",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;

      return DataRefugioModel.fromJson(responseData);
    } catch (e) {
      print("Error al obtener detalles del refugio: $e");
      return null;
    }
  }

  Future<void> createRefugio(RefugioModel refugio) async {
    final token = await Const.getStorage.read(key: "token") ?? "";

    try {
      final Response response = await dio.post(
        "$urlPostRefugio/",
        data: refugio.toJson(),
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        if (e.response != null) {
          print('Status code: ${e.response?.statusCode}');
          print('Response data: ${e.response?.data}');
        }
      } else {
        print('Error: $e');
      }
    }
  }

  Future<void> createAnimal({
    required String nombre,
    required String especie,
    required int edad,
    required double peso,
    required String sexo,
    required String raza,
    required String estadoSalud,
    required File image,
    required String estado,
  }) async {
    final token = await Const.getStorage.read(key: "token") ?? "";

    // Codificar la imagen en base64
    String base64Image = '';
    if (image.existsSync()) {
      final bytes = await image.readAsBytes();
      base64Image = base64Encode(bytes);
    }

    try {
      final Response response = await dio.post(
        "$urlCreateAnimal/",
        data: {
          'nombre': nombre,
          'especie': especie,
          'edad': edad,
          'peso': peso,
          'sexo': sexo,
          'raza': raza,
          'estadoSalud': estadoSalud,
          'image': base64Image, // Incluir la imagen en base64
          'estado': estado
        },
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        if (e.response != null) {
          print('Status code: ${e.response?.statusCode}');
          print('Response data: ${e.response?.data}');
        }
      } else {
        print('Error: $e');
      }
    }
  }

  Future<void> createPublicacion({
    required String id,
    required String titulo,
    required String texto,
    required File image,
    required String refugio,
  }) async {
    final token = await Const.getStorage.read(key: "token") ?? "";

    // Codificar la imagen en base64
    String base64Image = '';
    if (image.existsSync()) {
      final bytes = await image.readAsBytes();
      base64Image = base64Encode(bytes);
    }

    try {
      final Response response = await dio.post(
        "$urlPost/",
        data: {
          'id': id,
          'titulo': titulo,
          'texto': texto,
          'image': base64Image, // Incluir la imagen en base64
          'refugio': refugio
        },
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        if (e.response != null) {
          print('Status code: ${e.response?.statusCode}');
          print('Response data: ${e.response?.data}');
        }
      } else {
        print('Error: $e');
      }
    }
  }

  Future<void> deletePost(String id) async {
    final token = await Const.getStorage.read(key: "token") ?? "";

    try {
      final Response response = await dio.delete(
        "$urlPost$id",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        if (e.response != null) {
          print('Status code: ${e.response?.statusCode}');
          print('Response data: ${e.response?.data}');
        }
      } else {
        print('Error: $e');
      }
    }
  }
}
