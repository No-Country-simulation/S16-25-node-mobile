import 'package:app_patitas/home/models/animal_model.dart';
import 'package:app_patitas/home/models/refugio_model.dart';
import 'package:app_patitas/home/services/refugio_repository.dart';
import 'package:get/get.dart';

class RefugioController extends GetxController {
  RxList<RefugioModel> refugios = RxList<RefugioModel>([]);
  var mascotas = RxList<AnimalModel>([]);

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

  Future<void> fetchAnimals(List<String> ids) async {
    // Limpia la lista actual
    mascotas.clear();

    // Obtén datos para cada id
    for (var id in ids) {
      var animal = await getAnimals(id);
      if (animal != null) {
        mascotas.add(animal);
      }
    }
  }

  Future<AnimalModel?> getAnimals(String id) async {
    return await RefugiosRepository().getAnimals(id);
  }
}
