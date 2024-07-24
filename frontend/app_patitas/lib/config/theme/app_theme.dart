import 'package:app_patitas/config/constantes/const.dart';
import 'package:flutter/material.dart';

List<Color> primaryColorLight = [
  const Color(0xFF31A800),
  const Color(0xFF31A800),
];

Color primaryColorDark = const Color(0xFF31A800);

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    fontFamily: 'Georgia',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    ),
    colorSchemeSeed: Const.primaryColorTextOrange,
  );

  final ThemeData darkTheme = ThemeData(
    fontFamily: 'Georgia',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    ),
    colorSchemeSeed: Const.primaryColorTextOrange,
  );
}
