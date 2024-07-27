import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/home/models/publicaciones_model.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  final String urlPost = '${Const.baseUrl}post';
  final Dio dio = Dio();

  Future<List<PublicacionesModel>?> getPublicaciones() async {
    final token = await Const.getStorage.read(key: "token") ?? "";
    try {
      final response = await dio.get(
        urlPost,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      // Extraer la lista de posts de la respuesta
      final Map<String, dynamic> responseData = response.data;
      final List<dynamic> posts = responseData['posts'];
      print("Respuesta del servidor: $posts");

      return posts.map((json) => PublicacionesModel.fromJson(json)).toList();
    } catch (e) {
      print("Error al obtener publicaciones: $e");
      return null;
    }
  }
}
