import 'package:app_patitas/config/constantes/const.dart';
import 'package:app_patitas/home/pages/home/home_publicaciones_list_page.dart';
import 'package:app_patitas/home/pages/perfil/perfil_page.dart';
import 'package:app_patitas/home/pages/refugios/refugios_page.dart';
import 'package:app_patitas/home/pages/veterinarias/veterinarias_page.dart';
import 'package:flutter/material.dart';

// HomePage
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final List<Widget> _widgetOptions = <Widget>[
    HomePublicacionesListPage(),
    RefugiosPage(),
    VeterinariasPage(),
    PerfilPage(),
    PerfilPage(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<String?> _getToken() async {
    return await Const.getStorage.read(key: "token");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getToken(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        /*if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }*/
        return Scaffold(
          appBar: snapshot.data == null
              ? AppBar(
                  backgroundColor: Const.colorTextWhite,
                  title: Text("¡PatitasEnRed!",
                      style: TextStyle(color: Const.primaryColorTextOrange)),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.health_and_safety_sharp,
                          size: 40, color: Const.primaryColorTextOrange),
                      onPressed: () {},
                    ),
                  ],
                )
              : AppBar(
                  title: Text("¡PatitasEnRed!",
                      style: TextStyle(color: Const.primaryColorTextOrange)),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.notification_important,
                          size: 40, color: Const.primaryColorTextOrange),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.health_and_safety_sharp,
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
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.apartment),
                label: 'Refugios',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.pets_sharp,
                  size: 40,
                  color: Colors.black,
                ),
                label: "+",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Veterinarias',
              ),
              BottomNavigationBarItem(
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
