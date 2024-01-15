import 'package:flutter/material.dart';

import 'package:cramming_poems/Data/poem_list.dart';
import 'package:cramming_poems/Widgets/confirmation_box.dart';

import 'package:cramming_poems/colors.dart';
import 'package:cramming_poems/styles.dart';

class PoemChooser extends StatefulWidget {
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
                    return GestureDetector(
                      child: Card(
                        child: ListTile(
                          title: Text(
                            poemList[index].title,
                            style: TextStyle(
                              fontSize: 25,
                            ),
                            //style: Theme.of(context).textTheme.titleLarge,
                          ),
                          selected: index == poemList.selectedIndex,
                          onTap: () {
                            setState(() {
                              poemList.selectedIndex = index;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      onLongPress: () async {
                        await confirmation_box(
                            context: context,
                            text: 'Удалить стих?',
                            textOK: 'Удалить',
                            textOFF: 'Отмена',
                            functionOK: () {
                              setState(() {
                                poemList.removePoemAt(index);
                                if (poemList.length == 0) {
                                  poemList.newPoem();
                                }
                              });
                            });
                      },
                    );
                  }),
            ),
          ),
          Container(
            color: ColorBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  style: buttonStyleOK,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      poemList.newPoem();
                    });
                    //Navigator.pop(context);  // закрытие окна выбора стиха
                  },
                ),
                IconButton(
                  style: buttonStyleOFF,
                  icon: const Icon(Icons.delete_forever_sharp),
                  onPressed: () async {
                    await confirmation_box(
                        context: context,
                        text: 'Удалить все стихи?',
                        textOK: 'Удалить все',
                        textOFF: 'Отмена',
                        functionOK: () {
                          setState(() {
                            poemList.clear();
                          });
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
