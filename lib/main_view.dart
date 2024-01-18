import 'package:flutter/material.dart';

import 'package:cramming_poems/Data/poem_list.dart';
import 'package:cramming_poems/Data/editModeController.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainView();
}

class _MainView extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: (!editModeController.isEditMode)
                  ? [
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
                              editModeController.toggleEditModeOn();
                            });
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Режим Редактирования"),
                            ));
                          },
                          icon: const Icon(Icons.edit)),
                    ]
                  : [
                      TextField(controller: editModeController.titleController, style: Theme.of(context).textTheme.bodyLarge),
                      TextField(
                        controller: editModeController.textController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: null,
                      ),
                      IconButton(
                          onPressed: () {
                            // TODO вынеси в отдельны метод, если не лень
                            setState(() {
                              editModeController.toggleEditModeOff();
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
