import 'dart:convert';
import 'dart:io';
import 'package:app_patitas/auth/models/user_model.dart';
import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/config/router/app_router.dart';
import 'package:dio/dio.dart' as dio; // Alias para Dio
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  final String urlLogin = '${Const.baseUrl}auth/login';
  final String urlRegister = '${Const.baseUrl}auth/register';
  final String urlUserProfile = '${Const.baseUrl}auth/profile';
  final String urlEditUserProfile = '${Const.baseUrl}user/';

  Future<Map<String, dynamic>?> login(UserModel user) async {
    try {
      final response = await dio.Dio().post(
        urlLogin,
        data: {
          'email': user.email,
          'password': user.password,
        },
      );

      if (response.statusCode == 200) {
        await Const.getStorage
            .write(key: "token", value: response.data["token"]);
        await Const.getStorage.write(key: "rol", value: response.data["rol"]);
        await Const.getStorage.write(key: "idUser", value: response.data["id"]);
        return response.data;
      }
    } on dio.DioException catch (e) {
      Get.snackbar(
        'Error',
        e.response?.data["message"] ?? 'Error desconocido',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
    }
    return null;
  }

  Future<Map<String, dynamic>?> register(UserModel user) async {
    try {
      final response = await dio.Dio().post(
        urlRegister,
        data: {
          'nombre': user.name,
          'email': user.email,
          'password': user.password,
          'documento': user.document,
          'tipoDocumento': user.typodocument,
        },
      );

      if (response.statusCode == 201) {
        return response.data;
      } else {
        debugPrint("Error ${response.statusCode}: ${response.statusMessage}");
      }
    } on dio.DioException catch (e) {
      Get.snackbar(
        'Error',
        "Error al registrar, por favor inténtelo de nuevo.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
    }
    return null;
  }

  Future<Map<String, dynamic>> profile(String id) async {
    final token = await Const.getStorage.read(key: "token");

    try {
      final response = await dio.Dio().get(
        "$urlUserProfile/$id",
        options: dio.Options(headers: {"Authorization": "Bearer $token"}),
      );

      return response.data as Map<String, dynamic>;
    } on dio.DioException catch (e) {
      Get.snackbar(
        'Error',
        e.response?.data["message"] ?? 'Error desconocido',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      rethrow; // Re-lanzar la excepción para manejarla en el controlador si es necesario
    }
  }

  Future<bool> editProfile({
    required String nombre,
    required String email,
    required String telefono,
    required File image,
  }) async {
    final token = await Const.getStorage.read(key: "token");
    final id = await Const.getStorage.read(key: "idUser");

    // Codificar la imagen en base64
    String base64Image = '';
    if (image.existsSync()) {
      final bytes = await image.readAsBytes();
      base64Image = base64Encode(bytes);
    }

    // Crear el JSON con los datos y la imagen en base64
    final Map<String, dynamic> data = {
      'nombre': nombre,
      'email': email,
      'telefono': telefono,
      'imagenPerfil': base64Image,
    };

    try {
      final response = await dio.Dio().put(
        "$urlEditUserProfile$id",
        data: data,
        options: dio.Options(
          headers: {"Authorization": "Bearer $token"},
          contentType: 'application/json',
        ),
      );

      if (response.statusCode == 202) {
        Get.snackbar(
          'Información',
          'Información actualizada correctamente',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        );
        return true;
      } else {
        Get.snackbar(
          'Error',
          'Error al actualizar la información',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: const Icon(Icons.error_outline, color: Colors.white),
        );
        return false;
      }
    } catch (e) {
      print('Error al actualizar perfil: $e');
      Get.snackbar(
        'Error',
        'Error inesperado',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      return false;
    }
  }
}
