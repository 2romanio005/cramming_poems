import 'package:flutter/material.dart';

import 'package:cramming_poems/Data/poemList.dart';
import 'package:cramming_poems/Data/poem.dart';

class EditingModeController{
  final titleController = TextEditingController();
  final textController = TextEditingController();
  bool _isEditMode = false;

  bool get isEditMode{
    return _isEditMode;
  }

  void enableEditingMode() {
    _isEditMode = true;
    titleController.text = poemList.selectedPoem.title;
    textController.text = poemList.selectedPoem.text.join("\n");
  }

  void completeEditingMode() {
    _isEditMode = false;
    poemList.selectedPoem = Poem(
      text: textController.text.split('\n'),
      title: titleController.text,
    ); // заменяем старый стих на новый
  }

  void cancelEditingMode(){
    _isEditMode = false;
  }

}

EditingModeController editingModeController = EditingModeController();