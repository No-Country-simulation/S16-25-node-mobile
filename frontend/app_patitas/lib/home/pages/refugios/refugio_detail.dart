import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/home/pages/home/home_publicaciones_list_page.dart';
import 'package:app_patitas/home/pages/refugios/widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefugioDetail extends StatelessWidget {
  const RefugioDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Contenedor para el título y el TabBar con la imagen de fondo
              Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/descarga.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                        const Text(
                          'Refugio Buenos Aires',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          width: 400,
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.white,
                          ),
                          child: TabBar(
                            indicator: BoxDecoration(
                              color: Colors
                                  .orange, // Color de fondo de la pestaña seleccionada
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelColor: Colors
                                .white, // Color del texto de la pestaña seleccionada
                            unselectedLabelColor: Colors
                                .orange, // Color del texto de las pestañas no seleccionadas
                            indicatorSize: TabBarIndicatorSize.tab,
                            tabs: const [
                              Tab(text: 'Mascotas'),
                              Tab(text: 'Publicaciones'),
                              Tab(text: 'Información'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Adopción Prioritaria",
                style: TextStyle(color: Colors.orange),
              ),
              // Contenedor para el TabBarView sin la imagen de fondo
              const Expanded(
                child: TabBarView(
                  children: [
                    MascotasTab(),
                    HomePublicacionesListPage(),
                    InformacionTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MascotasTab extends StatelessWidget {
  const MascotasTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(2, (index) {
        return GestureDetector(
          onTap: () {
            Get.dialog(const CardWidget());
            /*Get.generalDialog(
                pageBuilder: (context, animation, secondaryAnimation) {
              return const Center(child: CardWidget());
            });*/
          },
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    index == 0
                        ? 'https://example.com/dog1.jpg'
                        : 'https://example.com/dog2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    index == 0 ? 'Blanca (5 años)' : 'Lila (3 años)',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class PublicacionesTab extends StatelessWidget {
  const PublicacionesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Publicaciones',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class InformacionTab extends StatelessWidget {
  const InformacionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Información',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
