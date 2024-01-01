import 'package:flutter/material.dart';

import 'Data/poem_data.dart';

class MainView extends StatefulWidget {
  const MainView({super.key, required this.poemData});

  final PoemData poemData;
  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView> {
  bool _isEditMode = false;
  final nameController = TextEditingController();
  final authorController = TextEditingController();
  final textController = TextEditingController();

  // TODO: РАЗДЕЛИТЬ НА ДВА ВИДЖЕТА, ПРОСМОТР И РЕДАКТИРОВАНИЕ

  void _toggleEditModeOn() {
    const snackBar = SnackBar(
      content: Text("Режим Редактирования"),
    );

    setState(() {
      _isEditMode = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _toggleEditModeOff() {
    const snackBar = SnackBar(
      content: Text("Режим Просмотра"),
    );

    setState(() {
      _isEditMode = false;
      widget.poemData.name = nameController.text;
      widget.poemData.author = authorController.text;
      widget.poemData.text = textController.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    if (!_isEditMode) {
      return Column(
        children: [
          Text(widget.poemData.name, style: Theme.of(context).textTheme.bodyLarge),
          Text(widget.poemData.author, style: Theme.of(context).textTheme.bodySmall),
          Text(widget.poemData.text, style: Theme.of(context).textTheme.bodyMedium),
          IconButton(onPressed: _toggleEditModeOn, icon: const Icon(Icons.edit))
        ],
      );
    } else {
      return Column(
        children: [
          TextField(controller: nameController, style: Theme.of(context).textTheme.bodyLarge),
          TextField(controller: authorController, style: Theme.of(context).textTheme.bodySmall),
          TextField(
              controller: textController,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 15 // TODO: УБРАТЬ ОГРАНИЧЕНИЕ БЕЗ ПЕРЕПОЛНЕНИЯ
          ),
          IconButton(onPressed: _toggleEditModeOff, icon: const Icon(Icons.close))
        ],
      );
    }
  }
}