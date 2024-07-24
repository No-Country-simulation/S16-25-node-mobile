import 'package:app_patitas/auth/pages/register_and_login_page.dart';
import 'package:app_patitas/home/pages/home/home_page.dart';
import 'package:app_patitas/index/index_page.dart';
import 'package:app_patitas/onboarding/onepage.dart';
import 'package:app_patitas/splash/splash_page.dart';
import 'package:get/get.dart';

abstract class Routes {
  ///welcomer
  static const INITIAL = '/splash';
  static const ONBOARDING = '/onboarding';
  static const INDEX = '/index';

  //
  static const HOME = '/home';
  static const REGISTERANDLOGIN = '/registerandlogin';
}

class AppRouter {
  List<GetPage<dynamic>>? getPages() {
    return [
      GetPage(name: Routes.INITIAL, page: () => SplashPage()),
      GetPage(name: Routes.ONBOARDING, page: () => OnePage()),
      GetPage(name: Routes.INDEX, page: () => IndexPage()),

      //

      GetPage(
          name: Routes.REGISTERANDLOGIN, page: () => RegisterAndLoginPage()),

      GetPage(name: Routes.HOME, page: () => HomePage()),
    ];
  }
}
