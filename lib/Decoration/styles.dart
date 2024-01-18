import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cramming_poems/Decoration/colors.dart';

ThemeData mainTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: ColorPrimary,
    brightness: Brightness.light,
  ),
  textTheme: TextTheme(
    // TODO: Выбрать нормальные шрифты и размер текста
    titleLarge: GoogleFonts.oswald(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: GoogleFonts.oswald(
      // rubikMonoOne
      // quantico
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: GoogleFonts.robotoMono(
      // anonymousPro
      fontSize: 16,
    ),
    bodySmall:  GoogleFonts.robotoMono(
      fontSize: 10,
    ),
  ),
);

ButtonStyle buttonStyleOFF = IconButton.styleFrom(
  backgroundColor: ColorButtonBackground,
  hoverColor: ColorButtonHover,
  foregroundColor: ColorButtonForeground,
  highlightColor: ColorButtonPressedOFF,
);

ButtonStyle buttonStyleOK = IconButton.styleFrom(
  backgroundColor: ColorButtonBackground,
  hoverColor: ColorButtonHover,
  foregroundColor: ColorButtonForeground,
  highlightColor: ColorButtonPressedOK,
);

ButtonStyle buttonStyleDefault = IconButton.styleFrom(
  backgroundColor: ColorButtonBackground,
  hoverColor: ColorButtonHover,
  foregroundColor: ColorButtonForeground,
);

// TODO перенеси свои стили, а то я боюсь их трогать