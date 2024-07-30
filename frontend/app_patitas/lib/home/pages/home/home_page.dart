import 'package:app_patitas/home/pages/refugios/refugio_home_create_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_patitas/auth/pages/profile/user_profile_page.dart';
import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/home/pages/home/home_publicaciones_list_page.dart';
import 'package:app_patitas/home/pages/refugios/refugio_create_animal_page.dart';
import 'package:app_patitas/home/pages/refugios/refugio_create_publicacion_page.dart';
import 'package:app_patitas/home/pages/refugios/refugios_page.dart';
import 'package:app_patitas/home/pages/veterinarias/veterinarias_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String rol = '';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    load();
  }

  void load() async {
    final role = await Const.getStorage.read(key: "rol") ?? '';
    print("rol: $role");
    setState(() {
      rol = role;
    });
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
                    Get.to(() => RefugioCreateAnimalPage());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('Agregar Publicación'),
                  onTap: () {
                    Get.to(() => const RefugioCreatePublicacionPage());
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
    //print(await Const.getStorage.read(key: "rol"));
    return await Const.getStorage.read(key: "rol");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        final hasToken = snapshot.data != null;
        final widgetOptions = <Widget>[
          HomePublicacionesListPage(),
          rol == 'User' ? RefugiosPage() : RefugioHomeCreatePage(),
          const VeterinariasPage(),
          UserProfilePage(),
          UserProfilePage(),
        ];

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Const.colorTextWhite,
            title: const Text("¡PatitasEnRed!",
                style: TextStyle(color: Const.primaryColorTextOrange)),
            actions: hasToken
                ? [
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
                  ]
                : [
                    IconButton(
                      icon: const Icon(Icons.health_and_safety_sharp,
                          size: 40, color: Const.primaryColorTextOrange),
                      onPressed: () {},
                    ),
                  ],
          ),
          body: widgetOptions[_selectedIndex],
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
              if (rol == 'Admin')
                const BottomNavigationBarItem(
                  icon: Icon(Icons.apartment),
                  label: 'Mi Refugios',
                ),
              if (rol == 'User')
                const BottomNavigationBarItem(
                  icon: Icon(Icons.apartment),
                  label: 'Refugios',
                ),
              if (rol == 'User')
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
