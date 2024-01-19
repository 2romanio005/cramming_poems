import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

import 'package:cramming_poems/Decoration/colors.dart';

ThemeData mainTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorPrimary,
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    /// заголовок заголовков
    titleLarge: TextStyle(
      fontFamily: "Oswald",
      color: ColorHeader,
      fontSize: 27,
      fontWeight: FontWeight.bold,
    ),
    /// заголовок стиха
    titleMedium: TextStyle(
      fontFamily: "Oswald",
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    /// заголовок стиха в менюшке
    titleSmall: TextStyle(
      fontFamily: "Oswald",
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),

    /// осоновной текст стиха
    bodyMedium: TextStyle(
      fontFamily: "Consolas",
      fontSize: 16,
    ),

    /// заголовок всплывающих окон
    labelLarge: TextStyle(
      fontFamily: "Oswald",
      color: ColorFont,
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    /// текс всплывающих окон
    labelMedium: TextStyle(
      fontFamily: "Consolas",
      fontSize: 16,
    ),
    /// текст на кнопках
    labelSmall: TextStyle(
      fontFamily: "Consolas",
      color: ColorFont,
      fontSize: 20,
    ),
  ),
);

/// кнопка несогласия (краснеет)
ButtonStyle buttonStyleOFF = IconButton.styleFrom(
  backgroundColor: ColorButtonBackground,
  hoverColor: ColorButtonHover,
  foregroundColor: ColorButtonForeground,
  highlightColor: ColorButtonPressedOFF,
);
/// кнопка согласия (зеленеет)
ButtonStyle buttonStyleOK = IconButton.styleFrom(
  backgroundColor: ColorButtonBackground,
  hoverColor: ColorButtonHover,
  foregroundColor: ColorButtonForeground,
  highlightColor: ColorButtonPressedOK,
);
/// обычная кнопка (сереет)
ButtonStyle buttonStyleDefault = IconButton.styleFrom(
  backgroundColor: ColorButtonBackground,
  hoverColor: ColorButtonHover,
  foregroundColor: ColorButtonForeground,
);
