import 'package:flutter/material.dart';
import 'package:mytenera/config/constants.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: "Poppins",
    scaffoldBackgroundColor: kBackgroundColor,
    textTheme: textTheme(),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: kSecondaryColor, backgroundColor: kBackgroundColor),
    appBarTheme: const AppBarTheme(
      color: kBackgroundColor,
      elevation: 0,
    ),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    headlineLarge: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(color: kTextColor),
    headlineMedium: TextStyle(fontStyle: FontStyle.italic, color: kTextColor),
  );
}
