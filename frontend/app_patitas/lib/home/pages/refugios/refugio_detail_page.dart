import 'package:app_patitas/home/models/animal_model.dart';
import 'package:app_patitas/home/models/refugio_model.dart';
import 'package:app_patitas/home/pages/refugios/refugio_publicacion_page.dart';
import 'package:app_patitas/home/pages/refugios/widget/card_widget.dart';
import 'package:app_patitas/home/structures/controllers/refugio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefugioDetail extends StatefulWidget {
  final RefugioModel refugio;
  const RefugioDetail({super.key, required this.refugio});

  @override
  State<RefugioDetail> createState() => _RefugioDetailState();
}

class _RefugioDetailState extends State<RefugioDetail> {
  final RefugioController refugioController = Get.put(RefugioController());

  @override
  void initState() {
    super.initState();
    refugioController.getDetallesRefugio(widget.refugio.id!);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          child: Obx(() {
            final dataRefugio = refugioController.dataRefugio.value;
            if (dataRefugio == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                // Contenedor para el título y el TabBar con la imagen de fondo
                Stack(
                  children: [
                    Positioned.fill(
                      child: widget.refugio.image != null
                          ? Image.network(
                              widget.refugio.image!,
                              fit: BoxFit.fill,
                            )
                          : Image.asset(
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
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.orange,
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
                const SizedBox(height: 10),
                const Text(
                  "Adopción Prioritaria",
                  style: TextStyle(color: Colors.orange),
                ),
                // Contenedor para el TabBarView sin la imagen de fondo
                Expanded(
                  child: TabBarView(
                    children: [
                      MascotasTab(data: dataRefugio.animales),
                      RefugioPublicacionPage(
                          publicaciones: dataRefugio.publicaciones,
                          refugio: widget.refugio),
                      const InformacionTab(),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class MascotasTab extends StatelessWidget {
  final List<Map<String, dynamic>>? data;

  const MascotasTab({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: data!.length,
      itemBuilder: (context, index) {
        final mascota = AnimalModel.fromJson(data![index]);

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
          child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.network(
                    mascota.image ?? 'assets/images/descarga.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${mascota.nombre} (${mascota.edad} años)',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
