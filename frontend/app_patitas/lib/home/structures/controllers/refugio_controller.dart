import 'dart:io';

import 'package:app_patitas/home/models/animal_model.dart';
import 'package:app_patitas/home/models/datarefugio_model.dart';
import 'package:app_patitas/home/models/publicaciones_model.dart';
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

  void createRefugio(RefugioModel refugio) async {
    await RefugiosRepository().createRefugio(refugio);
  }

  void createAnimal(
      {required nombre,
      required especie,
      required edad,
      required peso,
      required sexo,
      required raza,
      required estadoSalud,
      required image,
      required estado}) async {
    await RefugiosRepository().createAnimal(
        nombre: nombre,
        especie: especie,
        edad: edad,
        peso: peso,
        sexo: sexo,
        raza: raza,
        estadoSalud: estadoSalud,
        image: image,
        estado: estado);
  }

  void createPublicacion(
      {required id,
      required titulo,
      required texto,
      required File image,
      required refugio}) async {
    await RefugiosRepository().createPublicacion(
        id: id, titulo: titulo, texto: texto, image: image, refugio: refugio);
  }

  void deletePost(String id) async {
    await RefugiosRepository().deletePost(id);
  }
}
