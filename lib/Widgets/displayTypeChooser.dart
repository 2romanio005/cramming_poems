import 'package:flutter/material.dart';

import 'package:cramming_poems/Data/poem.dart';
import 'package:cramming_poems/Data/poemList.dart';

import 'package:cramming_poems/Decoration/colors.dart';

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
          Text("Выберите вид отображения", style: Theme.of(context).textTheme.titleMedium),
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
                              title: Text(namePoemDisplayType[PoemDisplayType.values[index]]!),
                              titleTextStyle: Theme.of(context).textTheme.titleSmall,
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

Map<PoemDisplayType, String> namePoemDisplayType = {
  PoemDisplayType.original: "Оригинал",
  PoemDisplayType.halfLineLeft: "Первая половина",
  PoemDisplayType.halfLineRight: "Вторая половина",
  PoemDisplayType.first7: "Первые 7 букв",
  PoemDisplayType.firstAndLast: "Первое и последнее слово",
  PoemDisplayType.first: "Первое слово",
  PoemDisplayType.last: "Последнее слово",
  PoemDisplayType.firstAndLastLetterEachWord: "Первая и последняя буква каждого слова",
  PoemDisplayType.firstLetterEachWord: "Первая буква каждого слова",
  PoemDisplayType.firstLetter: "Первая буква каждой строки",
};
