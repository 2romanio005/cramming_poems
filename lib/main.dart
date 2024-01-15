import 'package:flutter/material.dart';
import 'package:cramming_poems/future_builder.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FutureBuilderHome(),
      theme: ThemeData(
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
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: GoogleFonts.merriweather(
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
