import 'package:cramming_poems/Data/poem_list.dart';
import 'package:cramming_poems/main_view.dart';
import 'package:flutter/material.dart';

import 'package:cramming_poems/colors.dart';
import 'package:cramming_poems/poemChooser.dart';

import 'Data/poem.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {

  Poem selectedPoem = poemList.selectedPoem;

  newPoem() {
    setState(() {
      selectedPoem = poemList.selectedPoem;
    });
  }

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
        child: PoemChooser(onChange: newPoem),
      ),
      body: MainView(poemData: selectedPoem),
    );
  }
}
