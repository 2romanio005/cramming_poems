import 'package:flutter/material.dart';

import 'package:cramming_poems/Data/poem.dart';
import 'package:cramming_poems/Data/poem_list.dart';

import 'package:cramming_poems/colors.dart';
import 'package:cramming_poems/styles.dart';

class DisplayTypeChooser extends StatefulWidget {
  const DisplayTypeChooser({super.key, required this.onChange});

  final void Function() onChange;

  @override
  _DisplayTypeChooser createState() => _DisplayTypeChooser();
}

class _DisplayTypeChooser extends State<DisplayTypeChooser> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Text(
            "Выберите вид отображения",
            style: TextStyle(
              color: ColorHeader,
              fontSize: 30,
            ),
          ),
          Expanded(
            child: Container(
              color: ColorBackground,
              child: ListView.builder(
                  itemCount: namePoemDisplayType.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                namePoemDisplayType[PoemDisplayType.values[index]]!,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              selected: index == poemList.selectedPoemDisplayType.index,
                              onTap: () {
                                setState(() {
                                  poemList.selectedPoemDisplayType = PoemDisplayType.values[index];
                                });
                                widget.onChange();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
