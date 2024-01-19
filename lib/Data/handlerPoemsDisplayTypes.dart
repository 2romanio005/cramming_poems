//import 'dart:math';

class _OnePoemDisplayType {
  _OnePoemDisplayType({required this.name, required this.lineHandler});

  final String name;
  final List<String> Function(List<String>) lineHandler;
}

enum PoemDisplayType {
  original,
  halfLineLeft,
  halfLineRight,
  firstAndLast,
  first,
  last,
  firstAndLastLetterEachWord,
  firstLetterEachWord,
  twoLastLetterEachWord,
  first1,
  first7,
  voided,
}


class HandlerPoemsDisplayTypes {
  static String hidden = ".";
  static final Map<PoemDisplayType, _OnePoemDisplayType> _map = {
    PoemDisplayType.original: _OnePoemDisplayType(name: "Целиком", lineHandler: (poem) => poem),
    PoemDisplayType.halfLineLeft: _OnePoemDisplayType(name: "Левая половина", lineHandler: _halfLineLeft),
    PoemDisplayType.halfLineRight: _OnePoemDisplayType(name: "Правая половина", lineHandler: _halfLineRight),
    PoemDisplayType.firstAndLast: _OnePoemDisplayType(name: "Первое и последнее слово", lineHandler: _firstAndLast),
    PoemDisplayType.first: _OnePoemDisplayType(name: "Первое слово", lineHandler: _first),
    PoemDisplayType.last: _OnePoemDisplayType(name: "Последнее слово", lineHandler: _last),
    PoemDisplayType.firstAndLastLetterEachWord: _OnePoemDisplayType(name: "Первая и последняя буква каждого слова", lineHandler: _firstAndLastLetterEachWord),
    PoemDisplayType.firstLetterEachWord: _OnePoemDisplayType(name: "Первая буква каждого слова", lineHandler: _firstLetterEachWord),
    PoemDisplayType.twoLastLetterEachWord: _OnePoemDisplayType(name: "Последние две буквы каждого слова", lineHandler: _twoLastLetterEachWord),
    PoemDisplayType.voided: _OnePoemDisplayType(name: "Пустой", lineHandler: _voided),
    PoemDisplayType.first1: _OnePoemDisplayType(name: "Первая буква", lineHandler: _first1),
    PoemDisplayType.first7: _OnePoemDisplayType(name: "Первые 7 букв", lineHandler: _first7),
  };

  static List<String> getFormattedPoem(PoemDisplayType type, List<String> poem) {
    return _map[type]!.lineHandler(poem);
  }
  static String getNamePoemDisplayType(PoemDisplayType type) {
    return _map[type]!.name;
  }

  static get length{
    return _map.length;
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

  static List<String> _firstAndLast(List<String> poem) {
    List<String> result = [];
    for (String line in poem) {
      List<String> words = line.split(' ');
      int start = 0, fin = words.length;
      while (start < fin && words[start].isEmpty) {
        start++;
      }
      while (fin > start && words[fin - 1].isEmpty) {
        fin--;
      }

      for (int i = start + 1; i < fin - 1; i++) {
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
      int start = 0;
      while (start < words.length && words[start].isEmpty) {
        start++;
      }

      for (int i = start + 1; i < words.length; i++) {
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
      int fin = words.length;
      while (fin > 0 && words[fin - 1].isEmpty) {
        fin--;
      }

      for (int i = 0; i < fin - 1; i++) {
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

  static List<String> _twoLastLetterEachWord(List<String> poem) {
    return poem.map((line) => line.split(' ').map((word) => (word.length > 2) ? _hideNCharacters(word.length - 2) + word.substring(word.length - 2) : word).join(" ")).toList();
  }

  static List<String> _first1(List<String> poem) {
    return _firstN(poem, 1);
  }

  static List<String> _first7(List<String> poem) {
    return _firstN(poem, 7);
  }

  static List<String> _voided(List<String> poem){
    return poem.map((line) => line.split(' ').map((word) => _hideString(word)).join(" ")).toList();
  }



  static List<String> _firstN(List<String> poem, int n) {
    return poem.map((line) {
      int numberOfCharacters = 0;
      for (int found = 0; found < n && numberOfCharacters < line.length; numberOfCharacters++) {
        found += line[numberOfCharacters] == ' ' ? 0 : 1;
      }
      String preservedSpaces = line.substring(0, numberOfCharacters) + line.substring(numberOfCharacters).replaceAll(RegExp(r'[^ ]'), hidden);
      return preservedSpaces;
    }).toList();
  }

  static String _hideString(String string) => _hideNCharacters(string.length);

  static String _hideNCharacters(int value) => hidden * value;
}
