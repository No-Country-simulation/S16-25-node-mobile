import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/home/structures/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePublicacionesListPage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomePublicacionesListPage({super.key});
  var rol = '';

  void load() async {
    rol = await Const.getStorage.read(key: "rol") ?? '';
  }

  @override
  Widget build(BuildContext context) {
    load();
    print(rol);
    return Scaffold(
      body: Obx(() {
        if (homeController.publicaciones.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: homeController.publicaciones.length,
          itemBuilder: (context, index) {
            final refugio = homeController.publicaciones[index];
            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(refugio.refugio!["image"]),
                              radius: 20,
                            ),
                            const SizedBox(width: 8.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  refugio.refugio!["nombre"] ??
                                      'Nombre del refugio',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                    '2 hours ago'), // You may want to replace this with dynamic data
                              ],
                            ),
                          ],
                        ),
                        rol == 'admin'
                            ? PopupMenuButton(
                                onSelected: (value) {
                                  // Maneja las opciones seleccionadas aquí
                                  if (value == 'edit') {
                                    // Acción para editar publicación
                                    print('Editar publicación');
                                  } else if (value == 'delete') {
                                    // Acción para eliminar publicación
                                    print('Eliminar publicación');
                                  }
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    child: ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('Editar publicación'),
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: ListTile(
                                      leading:
                                          Icon(Icons.delete, color: Colors.red),
                                      title: Text('Eliminar publicación'),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      refugio.texto ?? 'Descripción no disponible',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 16.0),
                    Image.network(
                        refugio.image ?? 'https://via.placeholder.com/300x200'),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.thumb_up),
                          label: const Text('Me gusta'),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share),
                          label: const Text('Compartir'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
