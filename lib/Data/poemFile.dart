import 'dart:io';
import 'dart:core';

import 'package:cramming_poems/Data/poem.dart';

class PoemFile {
  PoemFile({required Poem poem, required File dataFile}) {
    _dataFile = dataFile;
    String path = _dataFile.path;
    _nextNumberInFileName = int.parse(path.substring(path.lastIndexOf('/') + 1, path.lastIndexOf('.'))) + 1;

    _poem = poem;
    // если файл существует то надо читать с него, а если отсутсвует то создать его и сохраниться в нем
    if (dataFile.existsSync()) {
      _readFromFile();
    } else {
      _writeInFile();
    }
  }

  /// Read Poem from it's file.
  Future _readFromFile() async {
    try {
      List<String> content = await _dataFile.readAsLines();
      String newTitle = content.last; // отделяем название из последней строки

      content.removeLast(); // удаляем название из основного текста
      poem.text = content; // прочитали оригинал
      poem.title = newTitle; // обязательно после запис оргинала
    } catch (error) {
      print(error);
    }
  }

  Future<void> _writeInFile() async {
    _dataFile.writeAsString("${poem.text.join("\n")}\n${poem.title}"); // записываем в файл оригинал текста и в конце - название
  }

  void deleteFile() {
    _dataFile.deleteSync();
  }

  int get nextNumberInFileName {
    return _nextNumberInFileName;
  }

  Poem get poem{
    return _poem;
  }

  set poem(Poem newPoem){
    //_poem = Poem.copy(newPoem);
    _poem = newPoem;
    _writeInFile();
  }

  late File _dataFile;
  late final int _nextNumberInFileName;
  late Poem _poem;
}
