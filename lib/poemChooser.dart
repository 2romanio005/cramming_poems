import 'package:flutter/material.dart';
import 'package:cramming_poems/colors.dart';
import 'package:cramming_poems/Data/poem.dart';

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
            "Выбирите стих",
            style: TextStyle(
              color: ColorHeader,
              fontSize: 30,
            ),
          ),
          Expanded(
            child: Container(
              color: ColorTmpG,
              child: ListView.builder(
                  itemCount: poemList.poems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: ListTile(
                        title: Text(poemList.poems[index].title),
                        selected: index == poemList.selectedIndex,
                        onTap: () {
                          setState(() {
                            poemList.selectedIndex = index;
                          });
                          //Navigator.pop(context);
                        },
                      ),
                      onLongPress: () async {
                        if (index == 0) {
                          return;
                        }
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
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Отмена',
                                          style: TextStyle(
                                            color: ColorFont,
                                            fontSize: 20,
                                          ))),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          poemList.removePoem(index);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Удалить',
                                          style: TextStyle(
                                            color: ColorFont,
                                            fontSize: 20,
                                          ))),
                                ],
                              );
                            });
                      },
                    );
                  }),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
