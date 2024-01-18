import 'package:flutter/material.dart';

import 'package:cramming_poems/Data/poem_list.dart';
import 'package:cramming_poems/Data/poem.dart';

class EditModeController{
  final titleController = TextEditingController();
  final textController = TextEditingController();
  bool _isEditMode = false;

  bool get isEditMode{
    return _isEditMode;
  }

  void toggleEditModeOn() {
    _isEditMode = true;
    titleController.text = poemList.selectedPoem.title;
    textController.text = poemList.selectedPoem.text.join("\n");
  }

  void toggleEditModeOff() {
    _isEditMode = false;
    poemList.selectedPoem = Poem(
      text: textController.text.split('\n'),
      title: titleController.text,
    ); // заменяем старый стих на новый
  }

}

EditModeController editModeController = EditModeController();