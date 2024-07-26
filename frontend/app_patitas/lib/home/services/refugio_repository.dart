import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/home/models/animal_model.dart';
import 'package:app_patitas/home/models/refugio_model.dart';
import 'package:dio/dio.dart';

class RefugiosRepository {
  final String urlPost = '${Const.baseUrl}refugio';
  final String urlAnimals = '${Const.baseUrl}animal';
  final String urlPostRefugio = '${Const.baseUrl}post';
  final Dio dio = Dio();

  Future<List<RefugioModel>?> getRefugios() async {
    final token = await Const.getStorage.read(key: "token") ?? "";
    try {
      final Response response = await dio.get(
        urlPost,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      // Verifica que la respuesta tenga el formato esperado
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;

      // Extrae la lista de refugios del mapa
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

  Future<AnimalModel?> getAnimals(String id) async {
    final token = await Const.getStorage.read(key: "token") ?? "";
    try {
      final Response response = await dio.get(
        "$urlAnimals/$id",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      // Verifica que la respuesta tenga el formato esperado
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;

      return AnimalModel.fromJson(responseData);
    } catch (e) {
      print("Error al obtener refugios: $e");
      return null;
    }
  }

  Future<AnimalModel?> getPublicaciones(String id) async {
    final token = await Const.getStorage.read(key: "token") ?? "";
    try {
      final Response response = await dio.get(
        "$urlPostRefugio/$id",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      // Verifica que la respuesta tenga el formato esperado
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;

      return AnimalModel.fromJson(responseData);
    } catch (e) {
      print("Error al obtener refugios: $e");
      return null;
    }
  }
}
