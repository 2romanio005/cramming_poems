import 'dart:core';
import 'dart:math';

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
    PoemDisplayType.first: _first,
    PoemDisplayType.last: _last,
    PoemDisplayType.firstAndLastLetterEachWord: _firstAndLastLetterEachWord,
    PoemDisplayType.firstLetterEachWord: _firstLetterEachWord,
    PoemDisplayType.firstLetter: _firstLetter,
  };

  static List<String> getFormattedPoem(PoemDisplayType type, List<String> poem) {
    return map[type]!(poem);
  }


  static List<String> _halfLineLeft(List<String> poem) {
    List<String> result = [];
    for (String line in poem) {
      List<String> words = line.split(' ');

      int toSkip = 0;
      for (String word in words) {
        if (word.isEmpty) toSkip++;
      }
      int halfLength = ((words.length - toSkip) / 2).floor();

      for (int i = 0, skipped = 0; i < words.length; i++) {
        words[i] = (i - skipped) >= halfLength ? _hideString(words[i]) : words[i];
        if (words[i].isEmpty) skipped++;
      }

      result.add(words.join(' '));
    }
    return result;
  }

  static List<String> _halfLineRight(List<String> poem) {
    List<String> result = [];
    for (String line in poem) {
      List<String> words = line.split(' ');

      int toSkip = 0;
      for (String word in words) {
        if (word.isEmpty) toSkip++;
      }
      int halfLength = ((words.length - toSkip) / 2).ceil();

      for (int i = 0, skipped = 0; i < words.length; i++) {
        words[i] = (i - skipped) < halfLength ? _hideString(words[i]) : words[i];
        if (words[i].isEmpty) skipped++;
      }

      result.add(words.join(' '));
    }
    return result;
  }

  static List<String> _first7(List<String> poem) {
    return poem.map((line) {
      int numberOfCharacters = 0;
      for (int found = 0; found < 7 && numberOfCharacters < line.length; numberOfCharacters++) {
        found += line[numberOfCharacters] == ' ' ? 0 : 1;
      }
      String preservedSpaces = line.substring(0, numberOfCharacters) + line.substring(numberOfCharacters).replaceAll(RegExp(r'[^ ]'), hide);
      return preservedSpaces;
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

  static List<String> _first(List<String> poem) {
    List<String> result = [];
    for (String line in poem) {
      List<String> words = line.split(' ');
      for (int i = 1; i < words.length; i++) {
        words[i] = _hideString(words[i]);
      }
      result.add(words.join(" "));
    }
    return result;
  }

  static List<String> _last(List<String> poem) {
    List<String> result = [];
    for (String line in poem) {
      List<String> words = line.split(' ');
      for (int i = 0; i < words.length - 1; i++) {
        words[i] = _hideString(words[i]);
      }
      result.add(words.join(" "));
    }
    return result;
  }

  static List<String> _firstAndLastLetterEachWord(List<String> poem) {
    return poem
        .map((line) => line.split(' ').map((word) {
              if (word.length <= 2) {
                return word;
              }
              String firstLetter = word[0];
              if (RegExp(r'[^a-zA-Z0-9a-яA-Я]').hasMatch(word[word.length - 1])) {
                String lastLetter = word[word.length - 2];
                String hiddenCharacters = _hideString(word.substring(1, word.length - 2));
                return firstLetter + hiddenCharacters + lastLetter + word[word.length - 1];
              }
              String lastLetter = word[word.length - 1];
              String hiddenCharacters = _hideString(word.substring(1, word.length - 1));
              return firstLetter + hiddenCharacters + lastLetter;
            }).join(' '))
        .toList();
  }

  static List<String> _firstLetterEachWord(List<String> poem) {
    return poem.map((line) => line.split(' ').map((word) => word.isNotEmpty ? word[0] + _hideNCharacters(word.length - 1) : word).join(" ")).toList();
  }

  static List<String> _firstLetter(List<String> poem) {
    return poem.map((line) {
      List<String> words = line.split(' ');

      if (words.isEmpty) return line;
      String firstWord = words[0];
      String firstLetter = firstWord.isNotEmpty ? firstWord[0] : '';

      String hiddenWords = words.skip(1).map(_hideString).join(' ');

      return firstLetter + hiddenWords;
    }).toList();
  }

  static String _hideString(String string) => _hideNCharacters(string.length);

  static String _hideNCharacters(int value) => hide * value;
}

enum PoemDisplayType { original, halfLineLeft, halfLineRight, first7, firstAndLast, first, last, firstAndLastLetterEachWord, firstLetterEachWord, firstLetter }
