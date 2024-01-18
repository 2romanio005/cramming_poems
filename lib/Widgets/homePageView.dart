import 'package:flutter/material.dart';

import 'package:cramming_poems/Data/poemList.dart';
import 'package:cramming_poems/Data/editingModeController.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageView();
}

class _HomePageView extends State<HomePageView> {
  void enableEditingMode() {
    setState(() {
      editModeController.enableEditingMode();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Режим Редактирования"),
    ));
  }

  void completeEditingMode() {
    setState(() {
      editModeController.completeEditingMode();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Изменения сохранены"),
    ));
  }

  void cancelEditingMode() {
    setState(() {
      editModeController.cancelEditingMode();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Изменения отменены"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: (!editModeController.isEditMode)
                  ? [
                      Text(poemList.selectedPoem.title, style: Theme.of(context).textTheme.titleMedium),
                      Text(
                        poemList.selectedFormatText.join("\n"),
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.clip,
                      ),
                      IconButton(onPressed: enableEditingMode, icon: const Icon(Icons.edit)),
                    ]
                  : [
                      TextField(controller: editModeController.titleController, style: Theme.of(context).textTheme.titleSmall),
                      TextField(
                        controller: editModeController.textController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: completeEditingMode, icon: const Icon(Icons.save)),
                          IconButton(onPressed: cancelEditingMode, icon: const Icon(Icons.cancel)),
                        ],
                      ),
                    ],
            ),
          )
        ],
      ),
    );
  }
}
