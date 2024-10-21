import 'package:flutter/material.dart';

abstract final class CustomTheme {
  static ThemeData createThemeDataFromBrightness(Brightness brightness) {
    final colorScheme = createColorSchemeFromBrightness(brightness);
    final appBarTheme = createAppBarThemeFromScheme(colorScheme);
    return ThemeData(colorScheme: colorScheme, appBarTheme: appBarTheme);
  }

  static ColorScheme createColorSchemeFromBrightness(Brightness brightness) {
    return ColorScheme.fromSeed(
      seedColor: Colors.orangeAccent,
      brightness: brightness,
    );
  }

  static AppBarTheme createAppBarThemeFromScheme(ColorScheme colorScheme) {
    return AppBarTheme(backgroundColor: colorScheme.inversePrimary);
  }
}
