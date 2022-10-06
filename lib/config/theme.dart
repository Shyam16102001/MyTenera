import 'package:flutter/material.dart';
import 'package:mytenera/config/constants.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: "Poppins",
    primarySwatch: Colors.indigo,
    scaffoldBackgroundColor: kBackgroundColor,
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: kSecondaryColor, backgroundColor: kBackgroundColor),
    appBarTheme: const AppBarTheme(
      backgroundColor: kBackgroundColor,
      foregroundColor: kPrimaryColor,
      elevation: 0,
    ),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    headlineLarge: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(color: kTextColor),
    titleSmall: TextStyle(color: kTextColor),
    headlineMedium: TextStyle(fontStyle: FontStyle.italic, color: kTextColor),
    bodyMedium: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: const BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}
