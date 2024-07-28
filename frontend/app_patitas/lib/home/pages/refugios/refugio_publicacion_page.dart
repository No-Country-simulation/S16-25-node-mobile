import 'package:app_patitas/home/models/refugio_model.dart';
import 'package:flutter/material.dart';

class RefugioPublicacionPage extends StatelessWidget {
  final List<Map<String, dynamic>>? publicaciones;
  final RefugioModel refugio;

  const RefugioPublicacionPage(
      {super.key, required this.publicaciones, required this.refugio});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: publicaciones!.length,
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        /* const Text(
                                '2 hours ago'),*/ // You may want to replace this with dynamic data
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Text(
                  refugioPublicaciones["titulo"] ?? 'Descripción no disponible',
                  style: const TextStyle(fontSize: 16.0),
                ),
                Text(
                  refugioPublicaciones["texto"] ?? 'Descripción no disponible',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 16.0),
                Image.network(refugioPublicaciones["image"] ??
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
    ));
  }
}
