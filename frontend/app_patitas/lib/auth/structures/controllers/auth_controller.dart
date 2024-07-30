import 'dart:io';

import 'package:app_patitas/config/constantes/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_patitas/auth/models/user_model.dart';
import 'package:app_patitas/auth/services/auth_repository.dart';
import 'package:app_patitas/config/router/app_router.dart';

class AuthController extends GetxController {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController documentController = TextEditingController();

  String? typodocumentController;
  RxBool isLoading = false.obs;
  RxMap<String, dynamic> user = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void login() async {
    isLoading.value = true; // Cambiar estado a cargando
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Todos los campos son obligatorios',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      isLoading.value = false; // Cambiar estado a no cargando
      return;
    }

    final result = await AuthRepository().login(UserModel(
      email: email,
      password: password,
    ));

    if (result != null) {
      isLoading.value = false;
      Get.offAllNamed(Routes.HOME);
    } else {
      isLoading.value = false; // Cambiar estado a no cargando en caso de error
    }
  }

  void register() async {
    String nombre = nombreController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String typodocument = typodocumentController ?? '';

    if (nombre.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        typodocument.isEmpty ||
        documentController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Todos los campos son obligatorios',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
      return;
    }

    String tipo = (documentController.text == '1') ? 'DNI' : 'Pasaporte';
    final result = await AuthRepository().register(UserModel(
      name: nombre,
      email: email,
      password: password,
      document: typodocument,
      typodocument: tipo,
    ));

    if (result != null) {
      Get.defaultDialog(
        title: "Registro Correcto",
        content: const Text("Se ha registrado correctamente"),
        textConfirm: "Ok",
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  void loadProfile() async {
    try {
      final idUser = await Const.getStorage.read(key: "idUser") ?? "";
      user.value = await AuthRepository().profile(idUser);
    } catch (e) {
      // Manejar el error si es necesario
      print('Error al cargar el perfil: $e');
    }
  }

  void logout() async {
    await Const.getStorage.delete(key: "token");
    await Const.getStorage.delete(key: "rol");
    await Const.getStorage.delete(key: "idUser");
    Get.offAllNamed(Routes.REGISTERANDLOGIN);
  }

  void editProfile(
      {required String nombre,
      required String email,
      required String telefono,
      required File image}) async {
    bool result = await AuthRepository().editProfile(
        nombre: nombre, email: email, telefono: telefono, image: image);

    if (result) {
      Get.offAllNamed(Routes.HOME);
    }
  }
}
