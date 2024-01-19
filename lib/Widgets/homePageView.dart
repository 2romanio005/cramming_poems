import 'package:flutter/material.dart';

import 'package:cramming_poems/Data/poemList.dart';
import 'package:cramming_poems/Data/editingModeController.dart';
import 'package:cramming_poems/Decoration/styles.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageView();
}

class _HomePageView extends State<HomePageView> {
  void enableEditingMode() {
    setState(() {
      editingModeController.enableEditingMode();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      showCloseIcon: true,
      duration: Duration(seconds: 1),
      dismissDirection: DismissDirection.none,
      content: Text("Режим Редактирования"),
    ));
  }

  void completeEditingMode() {
    setState(() {
      editingModeController.completeEditingMode();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      showCloseIcon: true,
      duration: Duration(seconds: 1),
      dismissDirection: DismissDirection.none,
      content: Text("Изменения сохранены"),
    ));
  }

  void cancelEditingMode() {
    setState(() {
      editingModeController.cancelEditingMode();
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      showCloseIcon: true,
      duration: Duration(seconds: 1),
      dismissDirection: DismissDirection.none,
      content: Text("Изменения отменены"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: (!editingModeController.isEditMode)
                  ? [
                      IconButton(onPressed: enableEditingMode, icon: const Icon(Icons.edit_outlined), style: buttonStyleDefault),
                      Text(
                        poemList.selectedPoem.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        poemList.selectedFormatText.join("\n"),
                        style: Theme.of(context).textTheme.bodyMedium,
                        overflow: TextOverflow.clip,
                      ),
                      IconButton(onPressed: enableEditingMode, icon: const Icon(Icons.edit_outlined), style: buttonStyleDefault),
                    ]
                  : [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(onPressed: cancelEditingMode, icon: const Icon(Icons.cancel), style: buttonStyleOFF),
                          IconButton(onPressed: completeEditingMode, icon: const Icon(Icons.save), style: buttonStyleOK),
                        ],
                      ),
                      TextField(
                        controller: editingModeController.titleController,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                        maxLines: null,
                        decoration: const InputDecoration(hintText: 'Названием станет первая строка стихотворения'),
                      ),
                      // autofocus,
                      // decoration:
                      //   InputDecoration(hintText: 'both', labelText: 'both'),
                      TextField(
                        controller: editingModeController.textController,
                        style: Theme.of(context).textTheme.bodyMedium,
                        decoration: const InputDecoration(hintText: 'Вставьте текст стихотворение.', ),
                        maxLines: null,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(onPressed: cancelEditingMode, icon: const Icon(Icons.cancel), style: buttonStyleOFF),
                          IconButton(onPressed: completeEditingMode, icon: const Icon(Icons.save), style: buttonStyleOK),
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
