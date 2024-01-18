import 'package:flutter/material.dart';

import 'package:cramming_poems/Data/poemList.dart';
import 'package:cramming_poems/Widgets/confirmationBox.dart';

import 'package:cramming_poems/Decoration/colors.dart';
import 'package:cramming_poems/Decoration/styles.dart';

class PoemChooser extends StatefulWidget {
  const PoemChooser({super.key, required this.onSelect, required this.onDelete, required this.onAdd});

  final void Function() onSelect;
  final void Function() onDelete;
  final void Function() onAdd;

  @override
  _PoemChooser createState() => _PoemChooser();
}

class _PoemChooser extends State<PoemChooser> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Text(
            "Выберите стих",
            style: TextStyle(
              color: ColorHeader,
              fontSize: 30,
            ),
          ),
          Expanded(
            child: Container(
              color: ColorBackground,
              child: ListView.builder(
                  itemCount: poemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                poemList[index].poem.title,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              selected: index == poemList.selectedPoemIndex,
                              onTap: () {
                                setState(() {
                                  poemList.selectedPoemIndex = index;
                                });
                                widget.onSelect();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          IconButton(
                            style: buttonStyleOFF,
                            icon: const Icon(Icons.delete_forever_sharp),
                            onPressed: () async {
                              await confirmationBox(
                                  context: context,
                                  text: 'Удалить стих?',
                                  textOK: 'Удалить',
                                  textOFF: 'Отмена',
                                  functionOK: () {
                                    setState(() {
                                      poemList.removePoemAt(index);
                                      widget.onDelete();
                                    });
                                  });
                            },
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            color: ColorBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  style: buttonStyleOK,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      poemList.newPoemFile();
                    });
                    widget.onAdd();
                    Navigator.pop(context); // закрытие окна выбора стиха
                  },
                ),
                IconButton(
                  style: buttonStyleOFF,
                  icon: const Icon(Icons.delete_forever_sharp),
                  onPressed: () async {
                    await confirmationBox(
                        context: context,
                        text: 'Удалить все стихи?',
                        textOK: 'Удалить все',
                        textOFF: 'Отмена',
                        functionOK: () {
                          setState(() {
                            poemList.clear();
                          });
                          widget.onSelect();
                          //Navigator.pop(context);  // закрытие окна выбора стиха
                        });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
