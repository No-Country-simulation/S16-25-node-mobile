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
  static const LOGIN = '/login';
  static const SIGNUP = '/signup';
}

class AppRouter {
  List<GetPage<dynamic>>? getPages() {
    return [
      GetPage(name: Routes.INITIAL, page: () => OnePage()),
      GetPage(name: Routes.ONBOARDING, page: () => OnePage()),
      GetPage(name: Routes.INDEX, page: () => IndexPage()),
    ];
  }
}
