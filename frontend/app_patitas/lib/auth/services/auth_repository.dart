import 'package:app_patitas/auth/models/user_model.dart';
import 'package:app_patitas/config/constantes/const.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  String urlLogin = '${Const.baseUrl}/login';
  String urlRegister = '${Const.baseUrl}/register';

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

  Future<Map<String, dynamic>> register(UserModel user) async {
    final response = await dio.post(
      urlRegister,
      data: {
        'name': user.name,
        'email': user.email,
        'password': user.password,
        'document': user.document,
      },
    );
    return response.data;
  }
}
