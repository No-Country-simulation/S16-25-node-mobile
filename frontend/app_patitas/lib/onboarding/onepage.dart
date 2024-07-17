import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnePage extends StatelessWidget {
  const OnePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Const.primaryColorTextOrange,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¡PatitasEnRed!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Const.colorTextWhite,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Dale una segunda oportunidad a los que no pueden',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Const.colorTextBlack,
                ),
              ),
              const SizedBox(height: 32),
              Image.asset(
                'assets/images/dog.png', // Ensure this path matches your asset
                height: 400,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Get.toNamed(Routes.INDEX);
                },
                icon: const Icon(Icons.pets),
                label: const Text('Step'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
