import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      contentPadding: const EdgeInsets.all(16.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
            ),
          ),
          const Text(
            'Esterilizado',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          const Center(
            child: Image(
              image: NetworkImage('https://via.placeholder.com/150'),
              height: 150,
              width: 150,
            ),
          ),
          const SizedBox(height: 16.0),
          const Text(
            'Nombre y Edad: Brandy (2 años)',
            style: TextStyle(fontSize: 16.0, color: Colors.orange),
          ),
          const Text('Raza: Mestizo', style: TextStyle(fontSize: 16.0)),
          const Text('Tamaño: Mediano', style: TextStyle(fontSize: 16.0)),
          const Text('Sexo: Hembra', style: TextStyle(fontSize: 16.0)),
          const Text('Peso: 20kg', style: TextStyle(fontSize: 16.0)),
          const Text('Estado: Atención Médica',
              style: TextStyle(fontSize: 16.0)),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Acción para adoptar
              },
              child: const Text(
                'Adoptar',
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
