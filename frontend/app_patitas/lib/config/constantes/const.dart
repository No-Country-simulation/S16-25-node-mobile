import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Const {
  static const FlutterSecureStorage getStorage = FlutterSecureStorage();
  static String baseUrl = dotenv.env['BASE_URL'].toString();

  static const Color primaryColorBoton = Color(0xFFE38300);
  static const Color primaryColorTextOrange = Color(0xFFE38300);
  static const Color colorTextWhite = Color(0xFFFFFFFF);
  static const Color colorTextBlack = Color(0xFF000000);
}
