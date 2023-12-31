import 'package:flutter/material.dart';
import 'package:cramming_poems/colors.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorBackground,
      appBar: AppBar(
        title: Text(
          //"CRAMMING POEMS",
          "ЗАУЧИВАНИЕ СТРИХОВ",
          style: TextStyle(
            color: ColorHeader,
            fontSize: 30,
          ),
        ),
      ),
      body: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("выбор стиха"),
              Text("выбор режима")
            ],
          ),
          Text("text"),
        ],
      )

    );
  }
}