import 'package:flutter/material.dart';

Color primaryColorLight = const Color(0xFFF08E05);

Color primaryColorDark = const Color(0xFF31A800);

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColorLight,
    fontFamily: 'Georgia',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: primaryColorLight),
  );

  final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColorDark,
    fontFamily: 'Georgia',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: primaryColorDark),
  );
}
