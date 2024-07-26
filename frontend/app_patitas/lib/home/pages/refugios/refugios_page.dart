import 'package:app_patitas/home/pages/refugios/refugio_detail_page.dart';
import 'package:app_patitas/home/structures/controllers/refugio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefugiosPage extends StatelessWidget {
  // Inicialización del controlador
  final RefugioController refugioController = Get.put(RefugioController());

  RefugiosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (refugioController.refugios.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Número de columnas
              mainAxisSpacing: 8.0, // Espacio entre filas
              crossAxisSpacing: 8.0, // Espacio entre columnas
            ),
            itemCount: refugioController.refugios.length,
            itemBuilder: (context, index) {
              final refugio = refugioController.refugios[index];
              return GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de detalle con el refugio seleccionado
                  Get.to(() => RefugioDetail(refugio: refugio));
                },
                child: Card(
                  color: Colors.white,
                  elevation: 4, // Añadir sombra a la tarjeta
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              refugio.image ??
                                  'https://via.placeholder.com/150',
                              height: 80,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.all(4.0),
                                color: Colors.black54,
                                child: Row(
                                  children: [
                                    const Icon(Icons.star,
                                        color: Colors.yellow, size: 16),
                                    const SizedBox(width: 4.0),
                                    const Text(
                                      '4.5',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          refugio.nombre ?? 'Refugio sin nombre',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Animales disponibles: 11',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
