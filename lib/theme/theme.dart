import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      surfaceTintColor: Colors.black,
    ),
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      surface: Colors.black,
      onSurface: Colors.white,
      surfaceTint: Colors.black12,
      primary: Colors.white,
      onPrimary: Colors.white,
    ),
    navigationBarTheme: NavigationBarThemeData(
      iconTheme: WidgetStatePropertyAll<IconThemeData>(IconThemeData(
        color: Colors.white,
        size: 30,
      )),
    ));
