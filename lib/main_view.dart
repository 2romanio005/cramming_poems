import 'package:cramming_poems/Data/poem_list.dart';
import 'package:flutter/material.dart';

import 'Data/poem.dart';

class MainView extends StatefulWidget {
  //final GlobalKey<_MainView> _key = GlobalKey();
  // void update(){
  //   _key.currentState!.redraw();
  // }

  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView> {
  // Poem selectedPoemCopy = Poem.copy(poemList.selectedPoem);  // работать мы будет с копией
  bool _isEditMode = false;
  final titleController = TextEditingController();
  final textController = TextEditingController();
  // void redraw(){  // я почитал, в flutter не принято пробрасывать перерисовку в детей, поэтому setState находиться в home
  //   setState(() {});
  // }

  void _toggleEditModeOn() {
    const snackBar = SnackBar(
      content: Text("Режим Редактирования"),
    );

    setState(() {
      _isEditMode = true;
      titleController.text = poemList.selectedPoem.title;
      textController.text = poemList.selectedPoem.text.join("\n");
    });

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _toggleEditModeOff() {
    const snackBar = SnackBar(
      content: Text("Режим Просмотра"),
    );

    setState(() {
      _isEditMode = false;
      poemList.selectedPoem = Poem(
        text: textController.text.split('\n'),
        title: titleController.text,
      ); // заменяем старый стих на новый
    });
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: (!_isEditMode)
                  ? [ // оставь так скобочки, так удобнее тестить, удаляй такие коментарии когда прочитаешь
                      Text(poemList.selectedPoem.title, style: Theme.of(context).textTheme.bodyLarge),
                      Text(
                        poemList.selectedFormatText.join("\n"),
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.clip,
                      ),
                      IconButton(onPressed: _toggleEditModeOn, icon: const Icon(Icons.edit)),
                    ]
                  : [
                      TextField(controller: titleController, style: Theme.of(context).textTheme.bodyLarge),
                      TextField(
                        controller: textController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: null,
                      ),
                      IconButton(onPressed: _toggleEditModeOff, icon: const Icon(Icons.save)),
                      //IconButton(onPressed: _toggleEditModeOff, icon: const Icon(Icons.cancel)),
                    ],
            ),
          )
        ],
      ),
    );
  }
}
