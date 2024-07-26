import 'package:app_patitas/auth/models/user_model.dart';
import 'package:app_patitas/config/constantes/const.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  String urlLogin = '${Const.baseUrl}auth/login';
  String urlRegister = '${Const.baseUrl}auth/register';

  final dio = Dio();

  Future<Map<String, dynamic>> login(UserModel user) async {
    final response = await dio.post(
      urlLogin,
      data: {
        'email': user.email,
        'password': user.password,
      },
    );
    return response.data;
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
        },
      );

      print("Respuesta del servidor: ${response.data}");

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print("Error ${response.statusCode}: ${response.statusMessage}");
      }
    } on DioError catch (e) {
      // Maneja el error de Dio aquí
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
