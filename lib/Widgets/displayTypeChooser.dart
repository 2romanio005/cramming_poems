import 'package:flutter/material.dart';

import 'package:cramming_poems/Data/poemList.dart';
import 'package:cramming_poems/Data/handlerPoemsDisplayTypes.dart';

import 'package:cramming_poems/Decoration/colors.dart';

class DisplayTypeChooser extends StatefulWidget {
  const DisplayTypeChooser({super.key, required this.onChange});

  final void Function() onChange;

  @override
  _DisplayTypeChooser createState() => _DisplayTypeChooser();
}

class _DisplayTypeChooser extends State<DisplayTypeChooser> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Text("Выберите отображение", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center,),
          Expanded(
            child: Container(
              color: ColorBackground,
              child: ListView.builder(
                  itemCount: HandlerPoemsDisplayTypes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Row(  // только для возможности использовать Expanded
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(HandlerPoemsDisplayTypes.getNamePoemDisplayType(PoemDisplayType.values[index]), textAlign: TextAlign.center),
                              titleTextStyle: Theme.of(context).textTheme.titleSmall,
                              selected: index == poemList.selectedPoemDisplayType.index,
                              onTap: () {
                                setState(() {
                                  poemList.selectedPoemDisplayType = PoemDisplayType.values[index];
                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  showCloseIcon: true,
                                  duration: Duration(seconds: 1),
                                  dismissDirection: DismissDirection.none,
                                  content: Text(HandlerPoemsDisplayTypes.getNamePoemDisplayType(poemList.selectedPoemDisplayType)),
                                ));
                                widget.onChange();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

