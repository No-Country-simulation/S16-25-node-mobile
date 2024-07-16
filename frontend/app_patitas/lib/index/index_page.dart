import 'package:flutter/material.dart';

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
                color: Colors.orange,
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
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
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
                // Navigate to Register or Login
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
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
                // Navigate to Register or Login
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
                    color: Colors.orange,
                    height: 36,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('o',
                      style: TextStyle(fontSize: 16, color: Colors.orange)),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.orange,
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
                // Navigate to help page
              },
            ),
          ],
        ),
      ),
    );
  }
}
