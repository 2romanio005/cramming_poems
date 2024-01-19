import 'package:flutter/material.dart';

import 'package:cramming_poems/Decoration/colors.dart';
import 'package:cramming_poems/Decoration/styles.dart';

Future<void> confirmationBox({
  required BuildContext context,
  String title = "",
  String text = "",
  required String textOK,
  required String textOFF,
  void Function()? functionOK,
  void Function()? functionOFF,
}) async {
  functionOK ??= () {};
  functionOFF ??= () {};
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.spaceAround,
          title: Text(title, textAlign: TextAlign.center),
          titleTextStyle: Theme.of(context).textTheme.labelLarge,
          content: Text(text),
          contentTextStyle: Theme.of(context).textTheme.labelMedium,
          actions: [
            ElevatedButton(
              style: buttonStyleOFF,
              child: Text(textOFF, style: Theme.of(context).textTheme.labelSmall),
              onPressed: () {
                functionOFF!();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: buttonStyleOK,
              child: Text(textOK, style: Theme.of(context).textTheme.labelSmall),
              onPressed: () {
                functionOK!();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
