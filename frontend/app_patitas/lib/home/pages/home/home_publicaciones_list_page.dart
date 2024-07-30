import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/config/router/app_router.dart';
import 'package:app_patitas/home/structures/controllers/home_controller.dart';
import 'package:app_patitas/home/structures/controllers/refugio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePublicacionesListPage extends StatefulWidget {
  HomePublicacionesListPage({super.key});

  @override
  State<HomePublicacionesListPage> createState() =>
      _HomePublicacionesListPageState();
}

class _HomePublicacionesListPageState extends State<HomePublicacionesListPage> {
  final HomeController homeController = Get.put(HomeController());

  final RefugioController refugioController = Get.put(RefugioController());

  @override
  Widget build(BuildContext context) {
    // Utiliza GetX para observar cambios en el rol
    return Scaffold(
      body: FutureBuilder<String>(
        future: _getRol(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final rol = snapshot.data ?? '';
            return Obx(() {
              if (homeController.publicaciones.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: homeController.publicaciones.length,
                itemBuilder: (context, index) {
                  final publicacion = homeController.publicaciones[index];
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
                                    backgroundImage: NetworkImage(
                                        publicacion.refugio!["image"]),
                                    radius: 20,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        publicacion.refugio!["nombre"] ??
                                            'Nombre del refugio',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text(
                                          '2 hours ago'), // Puedes reemplazar esto con datos dinámicos
                                    ],
                                  ),
                                ],
                              ),
                              rol == 'User'
                                  ? PopupMenuButton<String>(
                                      onSelected: (value) {
                                        // Maneja las opciones seleccionadas aquí
                                        if (value == 'edit') {
                                          // Acción para editar publicación
                                          print('Editar publicación');
                                        } else if (value == 'delete') {
                                          refugioController
                                              .deletePost(publicacion.id!);
                                          print(publicacion.id!);
                                          print('Eliminar publicación');
                                          // Si deseas reiniciar todos los controladores, puedes hacerlo aquí
                                          Get.offAndToNamed(Routes.HOME);
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
                                            leading: Icon(Icons.delete,
                                                color: Colors.red),
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
                            publicacion.texto ?? 'Descripción no disponible',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          const SizedBox(height: 16.0),
                          Image.network(publicacion.image ??
                              'https://via.placeholder.com/300x200'),
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
            });
          }
        },
      ),
    );
  }

  Future<String> _getRol() async {
    return await Const.getStorage.read(key: "rol") ?? '';
  }
}
