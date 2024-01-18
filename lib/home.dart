import 'package:flutter/material.dart';

import 'package:cramming_poems/poemChooser.dart';
import 'package:cramming_poems/displayTypeChooser.dart';
import 'package:cramming_poems/Data/editModeController.dart';
import 'package:cramming_poems/main_view.dart';

import 'package:cramming_poems/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  void redraw() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorBackground,
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.arrow_drop_down),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.list),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          "ЗАУЧИВАНИЕ СТИХОВ",
          style: TextStyle(
            color: ColorHeader,
            fontSize: 28,
          ),
        ),
      ),
      drawer: Container(
        margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: PoemChooser(
          onSelect: redraw,
          onDelete: redraw,
          onAdd: () {
            editModeController.enableEditingMode();
            redraw();
          },
        ),
      ),
      endDrawer: Container(
        margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: DisplayTypeChooser(onChange: redraw),
      ),
      body: MainView(),
    );
  }
}
