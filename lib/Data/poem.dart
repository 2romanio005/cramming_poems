import 'package:cramming_poems/Data/handlerPoemsDisplayTypes.dart';

class Poem {
  Poem({List<String> text = const [""], String title = ""}) {
    this.text = text;
    this.title = title; // обязательно после записи  _text
  }

  static Poem copy(Poem original) {
    return Poem(
      text: original._text,
      title: original._title,
    );
  }

  /// Sets a new title. If passed newTitle is empty, title is set to the first
  /// line of textLines
  set title(String newTitle) {
    if (newTitle.isEmpty) {
      _title = _text[0];
      return;
    }
    _title = newTitle;
  }

  String get title {
    return _title;
  }

  set text(List<String> newText) {
    if (newText.isEmpty) {
      _text = ["empty"];
      return;
    }
    _text = newText;
  }

  List<String> get text {
    return _text;
  }

  List<String> getFormattedText(PoemDisplayType type) {
    return HandlerPoemsDisplayTypes.getFormattedPoem(type, _text);
  }

  String getNamePoemDisplayType(PoemDisplayType type) {
    return HandlerPoemsDisplayTypes.getNamePoemDisplayType(type);
  }

  late String _title;
  late List<String> _text;
}

