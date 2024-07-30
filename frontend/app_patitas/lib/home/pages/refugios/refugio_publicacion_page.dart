import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/config/router/app_router.dart';
import 'package:app_patitas/home/models/refugio_model.dart';
import 'package:app_patitas/home/structures/controllers/refugio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefugioPublicacionPage extends StatelessWidget {
  final RefugioController refugioController = Get.find<RefugioController>();
  final List<Map<String, dynamic>>? publicaciones;
  final RefugioModel refugio;

  RefugioPublicacionPage({
    super.key,
    required this.publicaciones,
    required this.refugio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicaciones del Refugio'),
      ),
      body: FutureBuilder<String>(
        future: _getRol(), // Obtén el rol del usuario
        builder: (context, snapshot) {
          final rol =
              snapshot.data ?? ''; // Valor por defecto si la llamada es lenta

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: publicaciones?.length ?? 0,
            itemBuilder: (context, index) {
              final refugioPublicaciones = publicaciones![index];
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(refugio.image!),
                            radius: 20,
                          ),
                          const SizedBox(width: 8.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                refugio.nombre ?? 'Nombre del refugio',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              // Aquí puedes agregar una fecha dinámica si está disponible
                            ],
                          ),
                          if (rol == 'User')
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                // Maneja las opciones seleccionadas aquí
                                if (value == 'edit') {
                                  // Acción para editar publicación
                                  print('Editar publicación');
                                } else if (value == 'delete') {
                                  refugioController
                                      .deletePost(refugioPublicaciones["id"]);
                                  print('Eliminar publicación');
                                  // Redirige a la pantalla de inicio
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
                                    leading:
                                        Icon(Icons.delete, color: Colors.red),
                                    title: Text('Eliminar publicación'),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        refugioPublicaciones["titulo"] ??
                            'Título no disponible',
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        refugioPublicaciones["texto"] ??
                            'Descripción no disponible',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      Image.network(
                        refugioPublicaciones["image"] ??
                            'https://via.placeholder.com/300x200',
                      ),
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
        },
      ),
    );
  }

  Future<String> _getRol() async {
    return await Const.getStorage.read(key: "rol") ?? '';
  }
}
