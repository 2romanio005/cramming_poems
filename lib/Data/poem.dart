import 'dart:core';
import 'dart:math';

class Poem {
  Poem({List<String> text = const [""], String title = ""}) {
    this.text = text;
    this.title = title; // обязательно после записи  _text
  }

  static Poem copy(Poem original){
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
    return _Helper.getFormattedPoem(type, _text);
  }


  late String _title;
  late List<String> _text;
}











class _Helper {
  static String hide = "_";
  static Map<PoemDisplayType, List<String> Function(List<String>)> map = {
    PoemDisplayType.original: (poem) => poem,
    PoemDisplayType.halfLineLeft: _halfLineLeft,
    PoemDisplayType.halfLineRight: _halfLineRight,
    PoemDisplayType.first7: _first7,
    PoemDisplayType.firstAndLast: _firstAndLast,
  };

  static List<String> getFormattedPoem(PoemDisplayType type, List<String> poem) {
    return map[type]!(poem);
  }

  static List<String> _halfLineRight(List<String> poem) {
    List<String> result = [];
    for (String line in poem) {
      List<String> words = line.split(' ');

      int halfLength = (words.length / 2).ceil();
      for (int i = 0; i < words.length; i++) {
        words[i] = i < halfLength ? _hideString(words[i]) : words[i];
      }

      result.add(words.join(' '));
    }
    return result;
  }

  static List<String> _halfLineLeft(List<String> poem) {
    List<String> result = [];
    for (String line in poem) {
      List<String> words = line.split(' ');

      int halfLength = (words.length / 2).floor();
      for (int i = 0; i < words.length; i++) {
        words[i] = i >= halfLength ? _hideString(words[i]) : words[i];
      }

      result.add(words.join(' '));
    }
    return result;
  }

  static List<String> _first7(List<String> poem) {
    return poem.map((line) {
      if (line.length <= 7) {
        return line;
      } else {
        int numberOfCharacters = min(7, line.length);
        String preservedSpaces = line.substring(0, numberOfCharacters) +
            line.substring(numberOfCharacters).replaceAll(RegExp(r'[^ ]'), hide);
        return preservedSpaces;
      }
    }).toList();
  }

  static List<String> _firstAndLast(List<String> poem) {
    List<String> result = [];
    for (String line in poem) {
      List<String> words = line.split(' ');
      for (int i = 1; i < words.length - 1; i++) {
        words[i] = _hideString(words[i]);
      }
      result.add(words.join(" "));
    }
    return result;
  }

  static String _hideString(String string) => hide * string.length;
}

enum PoemDisplayType {
  original,
  halfLineLeft,
  halfLineRight,
  first7,
  firstAndLast
}
