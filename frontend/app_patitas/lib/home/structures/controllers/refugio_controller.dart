import 'package:app_patitas/home/models/animal_model.dart';
import 'package:app_patitas/home/models/datarefugio_model.dart';
import 'package:app_patitas/home/models/refugio_model.dart';
import 'package:app_patitas/home/services/refugio_repository.dart';
import 'package:get/get.dart';

class RefugioController extends GetxController {
  RxList<RefugioModel> refugios = RxList<RefugioModel>([]);
  var dataRefugio = Rxn<DataRefugioModel>();
  var mascotas = <AnimalModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getRefugios();
  }

  void getRefugios() async {
    List<RefugioModel>? fetchedRefugios =
        await RefugiosRepository().getRefugios();
    if (fetchedRefugios != null) {
      refugios.value = fetchedRefugios;
    }
  }

  void getDetallesRefugio(String id) async {
    dataRefugio.value = await RefugiosRepository().getDetallesRefugio(id);
  }

  void setMascotas(List<AnimalModel> mascotasData) {
    mascotas.value = mascotasData;
  }
}
