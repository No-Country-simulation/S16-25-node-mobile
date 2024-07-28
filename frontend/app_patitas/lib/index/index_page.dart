import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              '¡PatitasEnRed!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Const.primaryColorTextOrange,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Elije una opción para continuar:',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Const.colorTextWhite,
                backgroundColor: Const.primaryColorTextOrange,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              icon: const Icon(Icons.pets),
              label: const Text(
                'Regístrate o Ingresa',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Get.offAllNamed(Routes.REGISTERANDLOGIN);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Const.colorTextBlack,
                backgroundColor: Const.colorTextWhite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              label: const Text(
                'Invitado',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Get.offAllNamed(Routes.HOME);
              },
            ),
            const SizedBox(height: 10),
            const Text(
              'Para la adopción el registro es obligatorio',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Row(
              children: <Widget>[
                Expanded(
                  child: Divider(
                    color: Const.primaryColorTextOrange,
                    height: 36,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('o',
                      style: TextStyle(
                          fontSize: 16, color: Const.primaryColorTextOrange)),
                ),
                Expanded(
                  child: Divider(
                    color: Const.primaryColorTextOrange,
                    height: 36,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.facebook),
                  iconSize: 40,
                  onPressed: () {
                    // Login with Facebook
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.g_mobiledata),
                  iconSize: 40,
                  onPressed: () {
                    // Login with Google
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  iconSize: 40,
                  onPressed: () {
                    // Login with X (formerly Twitter)
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              child: const Text('¿Necesitas ayuda personalizada?'),
              onPressed: () {
                Get.dialog(
                  Center(
                    child: Column(
                      children: [
                        Text("Te ayudaremos personalmente"),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Escribe tu email',
                          ),
                        ),
                        ElevatedButton(
                          child: Text("Enviar"),
                          onPressed: () {
                            //Get.back();
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
