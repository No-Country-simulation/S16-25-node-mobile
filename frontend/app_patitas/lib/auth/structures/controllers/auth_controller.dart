import 'package:app_patitas/auth/models/user_model.dart';
import 'package:app_patitas/auth/services/auth_repository.dart';
import 'package:app_patitas/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController nombreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? documentController;

  void login() {
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
      //Get.offAllNamed(Routes.HOME);
      debugPrint('Login correcto');
    }
  }

  void register() {
    String nombre = nombreController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String document = documentController ?? '';

    if (nombre.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        document.isEmpty) {
      Get.snackbar(
        'Error',
        'Todos los campos son obligatorios',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
    } else {
      AuthRepository().register(UserModel(
        name: nombreController.text,
        email: email,
        password: password,
        document: documentController,
      ));
      debugPrint('Login correcto');
    }
  }
}
