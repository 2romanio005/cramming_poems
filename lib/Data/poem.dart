import 'dart:io';
import 'dart:core';
import 'dart:math';
class Poem {
  Poem({List<String> textLines = const [""], String title = "", required File dataFile}) {
    _dataFile = dataFile;
    String path = _dataFile.path;
    _nextNumberInFileName = int.parse(path.substring(path.lastIndexOf('/') + 1, path.lastIndexOf('.'))) + 1;
    _textLines = textLines;
    this.title = title; // обязательно после записи  _differentTypesOfPoem, т.к может взять первую строку в качестве названия

    // если файл существует то надо читать с него, а если отсутсвует то создать его и сохраниться в нем
    if (dataFile.existsSync()) {
      _readFromFile();
    } else {
      writeInFile();
    }
  }

  /// Read Poem from it's file.
  Future _readFromFile() async {
    try {
      List<String> content = await _dataFile.readAsLines();
      String newTitle = content.last; // отделяем название из последней строки

      content.removeLast(); // удаляем название из основного текста
      _textLines = content; // прочитали оригинал
      title = newTitle; // обязательно после запис оргинала
    } catch (error) {
      print(error);
    }
  }

  Future<void> writeInFile() async {
    _dataFile.writeAsString("${_textLines.join("\n")}\n$_title"); // записываем в файл оригинал текста и в конце - название
  }

  void deleteFile() {
    _dataFile.deleteSync();
  }

  int get nextNumberInFileName {
    return _nextNumberInFileName;
  }

  /// Sets a new title. If passed newTitle is empty, title is set to the first
  /// line of textLines
  set title(String newTitle) {
    if (newTitle.isEmpty) {
      _title = _textLines[0];
      return;
    }
    _title = newTitle;
  }

  String get title {
    return _title;
  }

  List<String> get textLines {
    return _textLines;
  }

  List<String> getFormattedTextLines(PoemDisplayType type) {
    return _Helper.getFormattedPoem(type, _textLines);
  }

  set textLines(List<String> newTextLines) {
    if (newTextLines.isEmpty) {
      _textLines = ["empty"];
      return;
    }
    _textLines = newTextLines;
  }

  late File _dataFile;
  late final int _nextNumberInFileName;
  late String _title;
  late List<String> _textLines;
}

class _Helper {
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

  static List<String> _halfLineLeft(List<String> poem) {
    List<String> result = [];
    for (String line in poem) {
      List<String> words = line.split(' ');

      int halfLength = (words.length / 2).ceil();

      List<String> modifiedWords = words.map((word) {
        return words.indexOf(word) < halfLength ? _hideString(word) : word;
      }).toList();

      result.add(modifiedWords.join(' '));
    }
    return result;
  }

  static List<String> _halfLineRight(List<String> poem) {
    List<String> result = [];
    for (String line in poem) {
      List<String> words = line.split(' ');

      int halfLength = (words.length / 2).ceil();

      List<String> modifiedWords = words.map((word) {
        return words.indexOf(word) >= halfLength ? _hideString(word) : word;
      }).toList();

      result.add(modifiedWords.join(' '));
    }
    return result;
  }

  static List<String> _first7(List<String> poem) {
    return poem.map((line) {
      if (line.length <= 7) {
        return line;
      } else {
        int numberOfCharacters = min(7, line.length);
        String preservedSpaces = line.substring(0, numberOfCharacters) + line.substring(numberOfCharacters).replaceAll(RegExp(r'[^ ]'), '*');
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

  static String _hideString(String string) => "*" * string.length;
}

enum PoemDisplayType {
  original,
  halfLineLeft,
  halfLineRight,
  first7,
  firstAndLast
}