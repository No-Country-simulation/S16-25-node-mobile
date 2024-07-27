import 'package:app_patitas/auth/models/user_model.dart';
import 'package:app_patitas/config/constantes/const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthRepository {
  String urlLogin = '${Const.baseUrl}auth/login';
  String urlRegister = '${Const.baseUrl}auth/register';

  final dio = Dio();

  Future<Map<String, dynamic>?> login(UserModel user) async {
    try {
      final response = await dio.post(
        urlLogin,
        data: {
          'email': user.email,
          'password': user.password,
        },
      );

      if (response.statusCode == 200) {
        await Const.getStorage
            .write(key: "token", value: response.data["token"]);

        print(await Const.getStorage.read(key: "token"));
        return response.data;
      }

      return null;
    } on DioException catch (e) {
      // Maneja el error de Dio aquí
      Get.snackbar(
        'Error',
        e.response?.data["message"],
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      print("Error al registrar: ${e.message}");
      if (e.response != null) {
        print("Respuesta del servidor: ${e.response?.data["message"]}");
        print("Código de estado: ${e.response?.statusCode}");
      } else {
        print("Error de red o no se recibió respuesta del servidor.");
      }
      return null;
    }
  }

  Future<Map<String, dynamic>?> register(UserModel user) async {
    try {
      print("URL de registro: $urlRegister");

      final response = await dio.post(
        urlRegister,
        data: {
          'nombre': user.name,
          'email': user.email,
          'password': user.password,
          'documento': user.document,
          'tipoDocumento': user.typodocument,
        },
      );

      //Const.getStorage.write(key: "token", value: response.data["token"]);

      print("Respuesta del servidor: ${response.data}");

      if (response.statusCode == 201) {
        return response.data;
      } else {
        print("Error ${response.statusCode}: ${response.statusMessage}");
        return null;
      }
    } on DioException catch (e) {
      Get.snackbar(
        'Error',
        "Error al registrar, por favor intentelo de nuevo.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      print("Error al registrar: ${e.message}");
      if (e.response != null) {
        print("Respuesta del servidor: ${e.response?.data}");
        print("Código de estado: ${e.response?.statusCode}");
      } else {
        print("Error de red o no se recibió respuesta del servidor.");
      }
    }

    return null;
  }
}
