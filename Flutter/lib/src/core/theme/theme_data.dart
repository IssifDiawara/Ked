import 'package:flutter/material.dart';
import 'package:green_it/src/core/utils/extensions.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppTheme {
  ThemeData appThemeData() {
    return ThemeData(
      useMaterial3: true,
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 28),
        bodyLarge: TextStyle(fontSize: 18),
        bodyMedium: TextStyle(fontSize: 16),
      ),
      colorScheme: ColorScheme.light(
        primary: HexColor.fromHex('#0b6d36'),
        onPrimary: HexColor.fromHex('#ffffff'),
        secondary: HexColor.fromHex('#7c5800'),
        tertiary: HexColor.fromHex('#006b56'),
        error: HexColor.fromHex('#ba1a1a'),
        background: HexColor.fromHex('#f8fdff'),
        onBackground: HexColor.fromHex('#001f25'),
        onSecondary: HexColor.fromHex('#ffffff'),
        onTertiary: HexColor.fromHex('#ffffff'),
        outline: HexColor.fromHex('#717970'),
        primaryContainer: HexColor.fromHex('#9ef6b0'),
      ),
    );
  }
}
