// Configuramos la paleta de colores
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF00723F);
  static const Color secondary = Color(0xFF009E60);
  static const Color accent = Color(0xFF80E27E);

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
    colorScheme: ColorScheme.light(
      primary: primary,
      secondary: secondary,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFFF9F9F9),
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 2,
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black87)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
    colorScheme: ColorScheme.dark(
      primary: primary,
      secondary: secondary,
      surface: const Color(0xFF1E1E1E),
    ),
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: secondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
