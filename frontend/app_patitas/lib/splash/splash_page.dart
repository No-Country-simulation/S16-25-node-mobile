import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
    Future.delayed(const Duration(seconds: 3), () async {
      _checkSkipOnboarding().then((value) {
        if (storage.read("skipOnboarding") != null &&
            storage.read("skipOnboarding") == true) {
          if (storage.read("loginDataCustomer") != null) {
            load(storage.read("loginDataCustomer"));
            //print(storage.read("loginDataCustomer"));
            //Get.offAllNamed(Routes.HOME);
          } else {
            //print("vamos al login");
            //Get.offAllNamed(Routes.LOGIN);
          }
        } else {
          //print("vamos al onboarding");
          // Get.offAllNamed(Routes.ONBOARDING);
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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Image.asset(
              'assets/images/splash_image.png',
              width: 400,
            ),
          ),
          //Lottie.asset('assets/lottie/1.json')
        ],
      ),
    );
  }
}
