import 'dart:convert';

import 'package:app_patitas/auth/pages/profile/user_profile_edit_page.dart';
import 'package:app_patitas/home/pages/refugios/widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_patitas/auth/structures/controllers/auth_controller.dart';

class UserProfilePage extends StatefulWidget {
  UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    authController.loadProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            authController.logout();
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.red, // Color de fondo del botón
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Ajusta el padding si es necesario
          ),
          child: const Text(
            'Salir',
            style: TextStyle(color: Colors.white), // Color del texto
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.orange),
            onPressed: () {
              Get.to(UserProfileEditPage(user: authController.user.value));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (authController.user.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          var user = authController.user.value;
          //print(user);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: user["imagenPerfil"] != null
                    ? Image.memory(
                        base64Decode(user["imagenPerfil"]),
                        fit: BoxFit.cover,
                      ).image
                    : const NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/3135/3135768.png",
                      ),
              ),
              const SizedBox(height: 10),
              Text(
                user["nombre"] ?? 'Nombre no disponible',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Row(
                children: [
                  Text(
                    '4.5',
                    style: TextStyle(fontSize: 18),
                  ),
                  Icon(Icons.star, color: Colors.orange),
                ],
              ),
              const SizedBox(height: 10),
              InfoRow(
                  icon: Icons.badge,
                  text: user["documento"].toString() ??
                      'Documento no disponible'),
              InfoRow(
                  icon: Icons.email,
                  text: user["email"] ?? 'Correo no disponible'),
              InfoRow(
                  icon: Icons.phone,
                  text:
                      user["telefono"].toString() ?? 'Teléfono no disponible'),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Icon(Icons.pets, color: Colors.orange),
                  SizedBox(width: 5),
                  Text(
                    'Mascotas a su cargo:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: user["animales"]?.length ?? 0,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var mascota = user["animales"]?[index];
                    return GestureDetector(
                      onTap: () {
                        Get.dialog(
                          Center(
                            child: CardWidget(
                              mascota: mascota,
                            ),
                          ),
                        );
                      },
                      child: PetCard(
                        imageUrl: user["animales"]?[index]["imagen"] ?? '',
                        name: user["animales"]?[index]["nombre"] ?? '',
                        age: user["animales"]?[index]["edad"] ?? '',
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
              overflow:
                  TextOverflow.ellipsis, // Asegura que el texto no se desborde
            ),
          ),
        ],
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String age;

  const PetCard({
    required this.imageUrl,
    required this.name,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
          horizontal: 8.0), // Añadir margen entre tarjetas
      child: Column(
        children: [
          Image.network(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
          const SizedBox(height: 5),
          Text(name,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(age, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}
