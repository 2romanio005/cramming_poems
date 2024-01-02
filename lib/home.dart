import 'package:flutter/material.dart';
import 'package:cramming_poems/colors.dart';
import 'package:cramming_poems/Data/poem.dart';

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
      drawer: Drawer(
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
                    Navigator.pop(context);
                  },
                ),
                onLongPress: () async {
                  if(index == 0){
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
      body: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("выбор стиха"),
              Text("выбор режима"),
            ],
          ),
          Text("text"),
        ],
      )

    );
  }
}