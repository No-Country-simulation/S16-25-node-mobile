import 'package:app_patitas/home/pages/refugios/refugio_create_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RefugioHomeCreatePage extends StatelessWidget {
  const RefugioHomeCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'No existe un refugio creado,\npero no te preocupes aqui te ayudamos!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => RefugioCreatePage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // Color del botón
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(Icons.pets, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Crear refugio',
                      style: TextStyle(fontSize: 20),
                    ),
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
