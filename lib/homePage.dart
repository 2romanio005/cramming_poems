import 'package:flutter/material.dart';
import 'dart:math';

import 'package:cramming_poems/Widgets/poemChooser.dart';
import 'package:cramming_poems/Widgets/displayTypeChooser.dart';
import 'package:cramming_poems/Data/editingModeController.dart';
import 'package:cramming_poems/Widgets/HomePageView.dart';

import 'package:cramming_poems/Decoration/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  void redraw() {
    setState(() {});
  }

  void openDrawer(void Function() open) {
    if (editingModeController.isNotEditMode) {
      open();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        showCloseIcon: true,
        duration: Duration(milliseconds: 500),
        dismissDirection: DismissDirection.none,
        content: Text("Сначало сохраните стихотворение", textAlign: TextAlign.center),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorBackground,
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.visibility),
              onPressed: () => openDrawer(() => Scaffold.of(context).openEndDrawer()),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.list),
            onPressed: () => openDrawer(() => Scaffold.of(context).openDrawer()),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Запоминаем стихотворение",
              style: TextStyle(
                fontFamily: "Oswald",
                color: ColorFont,
                fontSize: min((MediaQuery.of(context).size.width - 100) / 12, 30),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      drawer: Container(
        margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: PoemChooser(
          onSelect: redraw,
          onDelete: redraw,
          onAdd: () {
            editingModeController.enableEditingMode();
            redraw();
          },
        ),
      ),
      endDrawer: Container(
        margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
        child: DisplayTypeChooser(onChange: redraw),
      ),

      body: HomePageView(), // не добавлять const а то всё перестаёт обновляться
    );
  }
}
