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
  PoemDisplayType poemDisplayType = PoemDisplayType.original;
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
        children: (!_isEditMode)
            ? [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton<PoemDisplayType>(
                      value: poemDisplayType,
                      onChanged: (PoemDisplayType? newValue) {
                        setState(() {
                          poemDisplayType = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: PoemDisplayType.original,
                          child: Text("Оригинал"),
                        ),
                        DropdownMenuItem(
                          value: PoemDisplayType.halfLineRight,
                          child: Text("Первая половина строки"),
                        ),
                        DropdownMenuItem(
                          value: PoemDisplayType.halfLineLeft,
                          child: Text("Вторая половина строки"),
                        ),
                        DropdownMenuItem(
                          value: PoemDisplayType.first7,
                          child: Text("Первых 7 букв"),
                        ),
                        DropdownMenuItem(
                          value: PoemDisplayType.firstAndLast,
                          child: Text("Первое и последнее каждой строки"),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(widget.poemData.title, style: Theme.of(context).textTheme.bodyLarge),
                    Text(
                      widget.poemData.getFormattedTextLines(poemDisplayType).join("\n"),
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.clip,
                    ),
                    IconButton(onPressed: _toggleEditModeOn, icon: const Icon(Icons.edit)),
                  ],
                ),
              ]
            : [
                Column(
                  children: [
                    TextField(controller: nameController, style: Theme.of(context).textTheme.bodyLarge),
                    TextField(
                      controller: textController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: null,
                    ),
                    IconButton(onPressed: _toggleEditModeOff, icon: const Icon(Icons.save)),
                  ],
                ),
              ],
      ),
    );
  }
}
