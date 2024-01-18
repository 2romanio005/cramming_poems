import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cramming_poems/Decoration/colors.dart';

ThemeData mainTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorPrimary,
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    /// название окна
    headlineMedium: GoogleFonts.oswald(
      color: ColorFont,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),

    /// заголовок заголовков
    titleMedium: GoogleFonts.oswald(
      color: ColorHeader,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    /// заголовок стиха
    titleSmall: GoogleFonts.oswald(
      // rubikMonoOne
      // quantico
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),

    /// осоновной текст стиха
    bodyMedium: GoogleFonts.robotoMono(
      // anonymousPro
      fontSize: 16,
    ),

    /// заголовок всплывающих окон
    labelLarge: GoogleFonts.oswald(
      color: ColorFont,
      fontSize: 25,
    ),
    /// текс всплывающих окон
    labelMedium: GoogleFonts.robotoMono(
      fontSize: 16,
    ),
    /// текст на кнопках
    labelSmall: GoogleFonts.robotoMono(
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
