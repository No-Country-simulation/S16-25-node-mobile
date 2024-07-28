import 'package:flutter/material.dart';

class ShowBottomSheet extends StatelessWidget {
  const ShowBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Editar publicación'),
                            onTap: () {
                              // Agrega tu lógica aquí
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.delete, color: Colors.red),
                            title: Text('Eliminar publicación'),
                            onTap: () {
                              // Agrega tu lógica aquí
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container()),
        ),
      ),
    );
  }
}
