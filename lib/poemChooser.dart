import 'package:flutter/material.dart';
import 'package:cramming_poems/colors.dart';
import 'package:cramming_poems/Data/poem_list.dart';

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
              color: ColorTmpG,     // TODO сделать нормальный дизайн
              child: ListView.builder(
                  itemCount: poemList.poems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: ListTile(
                        title: Text(
                          poemList.poems[index].title,
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
                      onLongPress: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Удалить стих?',
                                    style: TextStyle(
                                      color: ColorFont,
                                      fontSize: 25,
                                    )),
                                actions: [
                                  ElevatedButton(
                                    child: Text(
                                      'Отмена',
                                      style: TextStyle(
                                        color: ColorFont,
                                        fontSize: 20,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    child: Text(
                                      'Удалить',
                                      style: TextStyle(
                                        color: ColorFont,
                                        fontSize: 20,
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        poemList.removePoemAt(index);
                                        if(poemList.poems.length == 0){
                                          poemList.newPoem();
                                        }
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    );
                  }),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                poemList.newPoem();
              });
              //Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
