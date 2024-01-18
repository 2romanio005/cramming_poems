import 'package:flutter/material.dart';
import 'package:cramming_poems/futureBuilderHome.dart';

import 'package:cramming_poems/Decoration/styles.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FutureBuilderHome(),
      theme: mainTheme,
    );
  }
}
