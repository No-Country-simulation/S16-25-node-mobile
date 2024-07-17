import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController nombreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? documentController;

  void login() {
    String nombre = nombreController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String document = documentController!;
  }
}
