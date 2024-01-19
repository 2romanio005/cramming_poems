import 'package:flutter/material.dart';

import 'package:cramming_poems/Data/poemList.dart';
import 'package:cramming_poems/Widgets/confirmationBox.dart';
import 'package:cramming_poems/Data/editingModeController.dart';

import 'package:cramming_poems/Decoration/colors.dart';
import 'package:cramming_poems/Decoration/styles.dart';

class PoemChooser extends StatefulWidget {
  const PoemChooser({super.key, required this.onSelect, required this.onDelete, required this.onAdd});

  final void Function() onSelect;
  final void Function() onDelete;
  final void Function() onAdd;

  @override
  _PoemChooser createState() => _PoemChooser();
}

class _PoemChooser extends State<PoemChooser> {
  int _getIndex(int oldIndex){
    return poemList.length - oldIndex - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Text("Выберите стих", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center,),
          Expanded(
            child: Container(
              color: ColorBackground,
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 5),
                  itemCount: poemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    index = _getIndex(index);  // делаем вывод списка в обратном порядке
                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(poemList[index].poem.title, textAlign: TextAlign.center),
                              titleTextStyle: Theme.of(context).textTheme.titleSmall,
                              selected: index == poemList.selectedPoemIndex,
                              onTap: () {
                                if(editingModeController.isEditMode){
                                  editingModeController.completeEditingMode();
                                }
                                setState(() {
                                  poemList.selectedPoemIndex = index;
                                });
                                widget.onSelect();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          IconButton(
                            style: buttonStyleOFF,
                            icon: const Icon(Icons.delete_forever_sharp),
                            onPressed: () async {
                              await confirmationBox(
                                  context: context,
                                  title: 'Удалить стих?',
                                  text: "Стихотворение \"${poemList[index].poem.title}\" будет удалено.",
                                  textOK: 'Удалить',
                                  textOFF: 'Отмена',
                                  functionOK: () {
                                    setState(() {
                                      poemList.removePoemAt(index);
                                      widget.onDelete();
                                    });
                                  });
                            },
                          )
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 5),
            color: ColorBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  style: buttonStyleOK,
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      poemList.newPoemFile();
                    });
                    widget.onAdd();
                    Navigator.pop(context); // закрытие окна выбора стиха
                  },
                ),
                IconButton(
                  style: buttonStyleOFF,
                  icon: const Icon(Icons.delete_forever_sharp),
                  onPressed: () async {
                    await confirmationBox(
                        context: context,
                        title: 'Удалить все стихотворения?',
                        text: "Все стихотворения будут удалены.",
                        textOK: 'Удалить все',
                        textOFF: 'Отмена',
                        functionOK: () {
                          setState(() {
                            poemList.clear();
                          });
                          widget.onSelect();
                          //Navigator.pop(context);  // закрытие окна выбора стиха
                        });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
