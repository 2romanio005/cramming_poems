import 'package:cramming_poems/Data/poem_list.dart';
import 'package:flutter/material.dart';

import 'Data/poem.dart';

class MainView extends StatefulWidget {
  //final GlobalKey<_MainView> _key = GlobalKey();
  // void update(){
  //   _key.currentState!.redraw();
  // }

  /// это всё тут, потому что изменяется извне (при новом стихе надо включать режим редактирования) если найдёшь сопсоб запихнуть в _MainView то давай
  final titleController = TextEditingController();
  final textController = TextEditingController();
  bool _isEditMode = false;

  void toggleEditModeOn() {
    print("toggleEditModeOn ${poemList.selectedPoem.title}");
    _isEditMode = true;
    titleController.text = poemList.selectedPoem.title;
    textController.text = poemList.selectedPoem.text.join("\n");
  }

  void toggleEditModeOff() {
    _isEditMode = false;
    poemList.selectedPoem = Poem(
      text: textController.text.split('\n'),
      title: titleController.text,
    ); // заменяем старый стих на новый
  }

  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView> {
  // Poem selectedPoemCopy = Poem.copy(poemList.selectedPoem);  // работать мы будет с копией
  // void redraw(){  // я почитал, в flutter не принято пробрасывать перерисовку в детей, поэтому setState находиться в home
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: (!widget._isEditMode)
                  ? [
                      // оставь так скобочки, так удобнее тестить, удаляй такие коментарии когда прочитаешь
                      Text(poemList.selectedPoem.title, style: Theme.of(context).textTheme.bodyLarge),
                      Text(
                        poemList.selectedFormatText.join("\n"),
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.clip,
                      ),
                      IconButton(
                          onPressed: () {
                            // TODO вынеси в отдельны метод, если не лень
                            setState(() {
                              widget.toggleEditModeOn();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Режим Редактирования"),
                            ));
                          },
                          icon: const Icon(Icons.edit)),
                    ]
                  : [
                      TextField(controller: widget.titleController, style: Theme.of(context).textTheme.bodyLarge),
                      TextField(
                        controller: widget.textController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: null,
                      ),
                      IconButton(
                          onPressed: () {
                            // TODO вынеси в отдельны метод, если не лень
                            setState(() {
                              widget.toggleEditModeOff();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Режим Просмотра"),
                            ));
                          },
                          icon: const Icon(Icons.save)),
                      //IconButton(onPressed: _toggleEditModeOff, icon: const Icon(Icons.cancel)),
                    ],
            ),
          )
        ],
      ),
    );
  }
}
