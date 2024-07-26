import 'package:app_patitas/auth/models/user_model.dart';
import 'package:app_patitas/auth/services/auth_repository.dart';
import 'package:app_patitas/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController nombreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? typodocumentController;
  TextEditingController documentController = TextEditingController();
  bool isLoading = false;

  void login() async {
    isLoading = true;
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
    } else {
      if (await AuthRepository().login(UserModel(
            email: email,
            password: password,
          )) !=
          null) {
        isLoading = false;
        Get.offAllNamed(Routes.HOME);
        debugPrint('Login correcto1');
      }
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
    } else {
      /*print("Enviando datos al servidor...");
      print("name = $nombre");
      print("email = $email");
      print("password = $password");
      print("typodocument = $typodocument");
      print("document = ${documentController.text}");*/

      String tipo = (documentController.text == '1') ? 'DNI' : 'Pasaporte';
      if (await AuthRepository().register(UserModel(
              name: nombre,
              email: email,
              password: password,
              document: typodocument,
              typodocument: tipo)) !=
          null) {
        Get.defaultDialog(
            title: "Registro Correcto",
            content: const Text("Se ha registrado correctamente"),
            textConfirm: "Ok",
            onConfirm: () {
              Get.back();
            });
        debugPrint('Registro Correcto');
      }
    }
  }
}
