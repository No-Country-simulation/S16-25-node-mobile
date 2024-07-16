import 'package:app_patitas/auth/structures/controllers/auth_controller.dart';
import 'package:app_patitas/config/router/app_router.dart';
import 'package:app_patitas/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'PatitasEnRed',
        debugShowCheckedModeBanner: false,
        getPages: AppRouter().getPages(),
        //themeMode: ThemeMode.system,
        theme: AppTheme().lightTheme,
        //darkTheme: AppTheme().darkTheme,
        initialRoute: Routes.INITIAL,
        initialBinding: BindingsBuilder(
          () {
            Get.put<AuthController>(AuthController());
          },
        ));
  }
}
