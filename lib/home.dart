import 'package:flutter/material.dart';

import 'package:cramming_poems/colors.dart';
import 'package:cramming_poems/poemChooser.dart';

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
          margin: EdgeInsets.fromLTRB(0, 25, 0, 40),
          child: PoemChooser(),
        ),
        body: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("выбор режима"),
              ],
            ),
            Text("text"),
          ],
        ));
  }
}
