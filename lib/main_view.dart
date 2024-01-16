import 'package:flutter/material.dart';

import 'Data/poem.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.poemData});

  final Poem poemData;
  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView> {
  bool _isEditMode = false;
  final nameController = TextEditingController();
  final textController = TextEditingController();

  // TODO: РАЗДЕЛИТЬ НА ДВА ВИДЖЕТА, ПРОСМОТР И РЕДАКТИРОВАНИЕ

  void _toggleEditModeOn() {
    const snackBar = SnackBar(
      content: Text("Режим Редактирования"),
    );

    setState(() {
      _isEditMode = true;
      nameController.text = widget.poemData.title;
      textController.text = widget.poemData.textLines.join("\n");
    });

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _toggleEditModeOff() {
    const snackBar = SnackBar(
      content: Text("Режим Просмотра"),
    );

    setState(() {
      _isEditMode = false;
      widget.poemData.title = nameController.text;
      widget.poemData.textLines = textController.text.split("\n");
      widget.poemData.writeInFile();
    });

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("выбор режима"),
            ],
          ),
          if (!_isEditMode)
            Column(
              children: [
                Text(widget.poemData.title, style: Theme.of(context).textTheme.bodyLarge),
                Text(
                  widget.poemData.textLines.join("\n"),
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.clip,
                ),
                IconButton(onPressed: _toggleEditModeOn, icon: const Icon(Icons.edit)),
              ],
            )
          else
            Column(
              children: [
                TextField(controller: nameController, style: Theme.of(context).textTheme.bodyLarge),
                TextField(
                  controller: textController,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: null,
                ),
                IconButton(onPressed: _toggleEditModeOff, icon: const Icon(Icons.close)),
              ],
            ),
        ],
      ),
    );
  }
}