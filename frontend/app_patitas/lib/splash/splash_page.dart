import 'package:app_patitas/config/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:animate_do/animate_do.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _MyAppState();
}

class _MyAppState extends State<SplashPage> {
  GetStorage storage = GetStorage();
  bool shouldSkipOnboarding = false;

  void load(userJson) async {
    //UserModel dataUser = UserModel.fromJson(userJson);
    //await storage.write('loginDataCustomer', dataUser);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () async {
      _checkSkipOnboarding().then((value) {
        if (storage.read("skipOnboarding") != null &&
            storage.read("skipOnboarding") == true) {
          if (storage.read("loginDataCustomer") != null) {
            load(storage.read("loginDataCustomer"));
            //print(storage.read("loginDataCustomer"));
            //Get.offAllNamed(Routes.HOME);
          } else {
            //print("vamos al login");
            Get.offAllNamed(Routes.REGISTERANDLOGIN);
          }
        } else {
          //print("vamos al onboarding");
          Get.offAllNamed(Routes.ONBOARDING);
        }
      });
    });
  }

  Future<void> _checkSkipOnboarding() async {
    await Future.delayed(Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE38300),
      body: ZoomIn(
        duration: Duration(seconds: 2),
        child: Stack(
          children: [
            // Huella central
            Positioned(
              left: 140,
              top: 420,
              child: ZoomIn(
                duration: Duration(seconds: 4),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            // Primer dedo
            Positioned(
              left: 90,
              bottom: 410,
              child: ZoomIn(
                duration: Duration(seconds: 2),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            // Segundo dedo
            Positioned(
              left: 180,
              bottom: 450,
              child: ZoomIn(
                duration: Duration(seconds: 3),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            // Tercer dedo
            Positioned(
              left: 260,
              bottom: 410,
              child: ZoomIn(
                duration: Duration(seconds: 4),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            // Cuarto dedo
          ],
        ),
      ),
    );
  }
}
