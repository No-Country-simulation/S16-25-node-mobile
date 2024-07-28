import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/home/pages/home/home_publicaciones_list_page.dart';
import 'package:app_patitas/home/pages/perfil/perfil_page.dart';
import 'package:app_patitas/home/pages/refugios/refugios_page.dart';
import 'package:app_patitas/home/pages/veterinarias/veterinarias_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final List<Widget> _widgetOptions = <Widget>[
    HomePublicacionesListPage(),
    RefugiosPage(),
    const VeterinariasPage(),
    const PerfilPage(),
    const PerfilPage(),
  ];
  int _selectedIndex = 0;

  var rol = '';

  void load() async {
    rol = await Const.getStorage.read(key: "rol") ?? '';
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Agregar Animal'),
                  onTap: () {
                    // Agrega tu lógica aquí
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Agregar Publicación'),
                  onTap: () {
                    // Agrega tu lógica aquí
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<String?> _getToken() async {
    return await Const.getStorage.read(key: "token");
  }

  @override
  Widget build(BuildContext context) {
    load();
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        return Scaffold(
          appBar: snapshot.data == null
              ? AppBar(
                  backgroundColor: Const.colorTextWhite,
                  title: const Text("¡PatitasEnRed!",
                      style: TextStyle(color: Const.primaryColorTextOrange)),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.health_and_safety_sharp,
                          size: 40, color: Const.primaryColorTextOrange),
                      onPressed: () {},
                    ),
                  ],
                )
              : AppBar(
                  title: const Text("¡PatitasEnRed!",
                      style: TextStyle(color: Const.primaryColorTextOrange)),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.notification_important,
                          size: 40, color: Const.primaryColorTextOrange),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.health_and_safety_sharp,
                          size: 40, color: Const.primaryColorTextOrange),
                      onPressed: () {},
                    ),
                  ],
                ),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0.9,
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Const.colorTextWhite,
            selectedItemColor: Const.primaryColorTextOrange,
            unselectedItemColor: Colors.grey.withOpacity(0.5),
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.apartment),
                label: 'Refugios',
              ),
              if (rol == 'admin')
                const BottomNavigationBarItem(
                  icon: Icon(
                    Icons.pets_sharp,
                    size: 40,
                    color: Colors.black,
                  ),
                  label: "",
                ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Veterinarias',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Perfil',
              ),
            ],
          ),
        );
      },
    );
  }
}
