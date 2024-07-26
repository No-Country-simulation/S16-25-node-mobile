import 'package:app_patitas/home/models/publicaciones_model.dart';
import 'package:app_patitas/home/services/home_repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<PublicacionesModel> publicaciones = <PublicacionesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getPublicaciones();
  }

  void getPublicaciones() async {
    List<PublicacionesModel>? fetchedRefugios =
        await HomeRepository().getPublicaciones();
    if (fetchedRefugios != null) {
      publicaciones.value = fetchedRefugios;
    }
  }
}
