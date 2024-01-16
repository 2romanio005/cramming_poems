import 'package:flutter/material.dart';

import 'package:cramming_poems/colors.dart';
import 'package:cramming_poems/styles.dart';


Future<void> confirmation_box({
  required BuildContext context,
  required String text,
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
          title: Text(text,
              style: TextStyle(
                color: ColorFont,
                fontSize: 25,
              )),
          actions: [
            ElevatedButton(
              style: buttonStyleOFF,
              child: Text(
                textOFF,
                style: TextStyle(
                  color: ColorFont,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                functionOFF!();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: buttonStyleOK,
              child: Text(
                textOK,
                style: TextStyle(
                  color: ColorFont,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                functionOK!();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
