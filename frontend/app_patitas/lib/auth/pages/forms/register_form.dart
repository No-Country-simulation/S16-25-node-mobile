import 'package:app_patitas/auth/structures/controllers/auth_controller.dart';
import 'package:app_patitas/config/constantes/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterForm extends StatelessWidget {
  final authController = Get.find<AuthController>();
  RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Nombre',
              hintText: 'Nombre Apellidos',
              controlador: authController.nombreController,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              label: 'Correo electronico',
              hintText: 'Correo electronico',
              controlador: authController.emailController,
            ),
            const SizedBox(height: 10),
            _buildTextField(
              label: 'Contraseña',
              hintText: 'Contraseña',
              obscureText: true,
              controlador: authController.passwordController,
            ),
            const SizedBox(height: 10),
            _buildDropdownField(
              label: 'Documento',
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      authController.register();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Const.primaryColorTextOrange),
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Const.colorTextWhite),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                          fontSize: 20, color: Color.fromARGB(240, 99, 60, 1)),
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: Const.primaryColorTextOrange,
                    height: 36,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('o',
                      style: TextStyle(
                          fontSize: 16, color: Const.primaryColorTextOrange)),
                ),
                Expanded(
                  child: Divider(
                    color: Const.primaryColorBoton,
                    height: 36,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
            color: Const.primaryColorTextOrange,
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
        ),
      ],
    );
  }

  Widget _buildDropdownField({String? label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Const.primaryColorTextOrange,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                items: [
                  const DropdownMenuItem(
                    value: '1',
                    child: Text('DNI'),
                  ),
                  const DropdownMenuItem(
                    value: '2',
                    child: Text('Pasaporte'),
                  ),
                ],
                onChanged: (value) {
                  authController.documentController = value;
                },
                hint: const Text('Selecciona'),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: '0000000000',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
