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
  void dispose() {
    refugioController
        .dispose(); // Asegúrate de limpiar el controlador si es necesario
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Asegúrate de que el número coincida con las pestañas
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
                              fit: BoxFit.cover, // Cambiado a BoxFit.cover
                            )
                          : Image.asset(
                              'assets/images/descarga.png',
                              fit: BoxFit.cover, // Cambiado a BoxFit.cover
                            ),
                    ),
                    // Gradiente oscuro para mejorar la legibilidad
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
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
                          Text(
                            widget.refugio.nombre ?? 'Nombre del Refugio',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Container(
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
                                Tab(text: 'Donar'),
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
                      const InformacionTab(), // Asegúrate de tener la implementación correcta
                      const DonarTab(), // Nueva pestaña de "Donar"
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

class InformacionTab extends StatelessWidget {
  const InformacionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Información'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange, // Color del botón
                        foregroundColor: Colors.white),
                    onPressed: () {},
                    child: const Text('Contactar'),
                  ),
                ],
              ),
              const Section(
                title: 'Historia',
                content:
                    'ONG, sin fines de lucro. Estamos inscriptos, como Asociación Civil, REFUGIO EL CAMPITO personeria juridica nº 6971, Ruta16 Parcela 501 E Monte Grande, Partido de Esteban Echeverría, zona sur del Gran Buenos Aires, en Argentina.',
                showButton: true,
              ),
              const SizedBox(height: 16.0),
              const Section(
                title: 'Misión',
                content:
                    'El Campito Refugio es una ONG, sin fines de lucro. Estamos inscriptos, como Asociación Civil, REFUGIO EL CAMPITO personeria juridica nº 6971, Ruta16 Parcela 501 E Monte Grande, Partido de Esteban Echeverría, zona sur del Gran Buenos Aires, en Argentina.',
              ),
              const SizedBox(height: 16.0),
              const Section(
                title: 'Visión',
                content:
                    'El Campito Refugio es una ONG, sin fines de lucro. Estamos inscriptos, como Asociación Civil, REFUGIO EL CAMPITO personeria juridica nº 6971, Ruta16 Parcela 501 E Monte Grande, Partido de Esteban Echeverría, zona sur del Gran Buenos Aires, en Argentina.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DonarTab extends StatelessWidget {
  const DonarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Donar',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final String content;
  final bool showButton;

  const Section({
    required this.title,
    required this.content,
    this.showButton = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
            content,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
