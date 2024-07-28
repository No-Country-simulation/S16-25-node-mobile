import 'package:app_patitas/config/constantes/const.dart';
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
  bool shouldSkipOnboarding = false;

  void load() async {
    //print(await Const.getStorage.read(key: "token"));
    if (await Const.getStorage.read(key: "token") != null) {
      //print(storage.read("loginDataCustomer"));
      Get.offAllNamed(Routes.HOME);
    } else {
      //print("vamos al login");
      Get.offAllNamed(Routes.ONBOARDING);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () async {
      _checkSkipOnboarding().then((value) {
        load();
      });
    });
  }

  Future<void> _checkSkipOnboarding() async {
    await Future.delayed(Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ZoomIn(
        duration: Duration(seconds: 2),
        child: Center(
          child: Image.asset('assets/images/splash.png'),
        ),
      ),
    );
  }
}
