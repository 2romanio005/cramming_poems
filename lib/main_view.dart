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
  // Poem selectedPoemCopy = Poem.copy(poemList.selectedPoem);  // работать мы будет только с копией
  bool _isEditMode = false;
  final titleController = TextEditingController();
  final textController = TextEditingController();

  // void redraw(){
  //   setState(() {});
  // }

  // TODO: РАЗДЕЛИТЬ НА ДВА ВИДЖЕТА, ПРОСМОТР И РЕДАКТИРОВАНИЕ

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
      Poem poem = Poem(
        text: textController.text.split('\n'),
        title: titleController.text,
      );
      print(poemList.selectedPoem.text);
      print(poem.text);
      poemList.selectedPoem = poem; // копируем обратно (сохраяем копию вместо оригинала)
    });
    print(poemList.selectedPoem.text);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: (!_isEditMode)
            ? [
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
    );
  }
}
