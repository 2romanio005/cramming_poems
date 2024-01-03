import 'package:cramming_poems/main_view.dart';
import 'package:flutter/material.dart';

import 'package:cramming_poems/colors.dart';
import 'package:cramming_poems/poemChooser.dart';

import 'Data/poem_data.dart';

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
          "ЗАУЧИВАНИЕ СТИХОВ",
          style: TextStyle(
            color: ColorHeader,
            fontSize: 30,
          ),
        ),
      ),
      drawer: Container(
        margin: EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: PoemChooser(),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("выбор режима")
            ],
          ),
          MainView(poemData: PoemData("Название", "Автор", "Текст")),
        ],
      )

    );
  }
}
