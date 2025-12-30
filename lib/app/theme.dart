import 'package:flutter/material.dart';

const Color kPrimaryColor = Color(0xFF1A73E8);
const Color kSecondaryColor = Color(0xFF185ABC);
const Color kAccentColor = Color(0xFFF9AB00);
const Color kBackgroundColor = Color(0xFFF5F5F5);
const Color kCardColor = Color(0xFFFFFFFF);
const Color kTextPrimary = Color(0xFF1F1F1F);
const Color kTextSecondary = Color(0xFF5F6368);
const Color kErrorColor = Color(0xFFD93025);
const Color kSuccessColor = Color(0xFF188038);

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: kPrimaryColor,
    onPrimary: Colors.white,
    secondary: kSecondaryColor,
    onSecondary: Colors.white,
    error: kErrorColor,
    onError: Colors.white,
    surface: kCardColor,
    onSurface: kTextPrimary,
  ),
  scaffoldBackgroundColor: kBackgroundColor,
  cardColor: kCardColor,
  primaryColor: kPrimaryColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: kTextPrimary),
    bodyMedium: TextStyle(color: kTextPrimary),
    bodySmall: TextStyle(color: kTextSecondary),
    titleLarge: TextStyle(color: kTextPrimary, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: kTextPrimary),
    titleSmall: TextStyle(color: kTextSecondary),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  dialogTheme: const DialogThemeData(backgroundColor: kCardColor),
  // errorColor: kErrorColor,
  useMaterial3: true,
);
