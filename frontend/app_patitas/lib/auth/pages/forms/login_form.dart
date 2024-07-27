import 'package:app_patitas/auth/structures/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  final authController = Get.find<AuthController>();
  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /*const Text(
              '¡PatitasEnRed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
              textAlign: TextAlign.center,
            ),*/
            const SizedBox(height: 20),
            _buildTextField(
                label: 'Correo electronico',
                hintText: 'Correo electronico',
                controlador: authController.emailController),
            const SizedBox(height: 10),
            _buildTextField(
                label: 'Contraseña',
                hintText: 'Contraseña',
                obscureText: true,
                controlador: authController.passwordController),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      authController.login();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    child: authController.isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Ingresar',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle registration logic
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    child: const Text(
                      'Invitado',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(240, 99, 60, 1)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: Colors.orange,
                    height: 36,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('o',
                      style: TextStyle(fontSize: 16, color: Colors.orange)),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.orange,
                    height: 36,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook),
                  onPressed: () {
                    // Handle Facebook login
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.g_translate),
                  onPressed: () {
                    // Handle Google login
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.circle),
                  onPressed: () {
                    // Handle Twitter login
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {String? label,
      String? hintText,
      bool obscureText = false,
      TextEditingController? controlador}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        TextField(
          controller: controlador,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.grey),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0), // Cambia el color y el grosor del borde aquí
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0), // Borde cuando el TextField está habilitado
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1.0), // Borde cuando el TextField está enfocado
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                  color: Colors.grey, width: 1.0), // Borde cuando hay un error
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                  color: Colors.grey,
                  width:
                      1.0), // Borde cuando hay un error y el TextField está enfocado
            ),
          ),
          obscureText: obscureText,
        )
      ],
    );
  }
}
