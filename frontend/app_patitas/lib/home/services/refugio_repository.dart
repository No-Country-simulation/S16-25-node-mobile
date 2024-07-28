import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/home/models/datarefugio_model.dart';
import 'package:app_patitas/home/models/refugio_model.dart';
import 'package:dio/dio.dart';

class RefugiosRepository {
  final String urlPostRefugio = '${Const.baseUrl}refugio';
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
}
