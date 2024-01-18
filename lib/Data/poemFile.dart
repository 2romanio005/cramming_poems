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
      //print("Writing: $path");
      _writeInFile();
    }
  }

  /// Read Poem from it's file.
  // FIXME нельзя делать чтение асинхронным, точнее надо в poemList.creat как то дожидаться конце считывания иначе ловим баг на отображение несчитанных файло
  void _readFromFile() {
    try {
      List<String> content = _dataFile.readAsLinesSync();
      String newTitle = content.last; // отделяем название из последней строки

      content.removeLast(); // удаляем название из основного текста
      _poem.text = content; // прочитали оригинал
      _poem.title = newTitle; // обязательно после запис оргинала
      //print("Reading: ${_dataFile.path} as $newTitle");
    } catch (error) {
      print(error);
    }
  }

  Future<void> _writeInFile() async {
    try {
      _dataFile.writeAsString("${poem.text.join("\n")}\n${poem.title}"); // записываем в файл оригинал текста и в конце - название
    } catch(error){
      print(error);
    }
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
