import 'package:cramming_poems/Data/poem.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PoemList {
  PoemList._(this._directory) {
    _poems = [];
    // Poem(
    //   original: "я лучше всех\nвторая строка",
    //   title: "название",
    //   numberInFileName: 0,
    // ),
    // Poem(
    // original: "без названия",
    // title: "",
    // numberInFileName: 1,
    // ),
    // Poem(
    // original: "днинное оооооочень длинное название",
    // title: "",
    // numberInFileName: 2,
    // ),
  }

  // вместо конструктора чтобы использовать await
  static Future<PoemList> create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    directory = await Directory(directory.path + "/savedPoems").create(recursive: true);
    PoemList poemList = PoemList._(directory);

    final List<FileSystemEntity> entities = await directory.list(recursive: false).toList();
    final Iterable<File> files = entities.whereType<File>();
    //files.forEach(print);
    for (File file in files) {
      print("Чтение файла: ${file.path}");
      String path = file.path;
      int start = path.lastIndexOf('/') + 1;
      int end = path.lastIndexOf('.');
      if (end <= start) {
        print("Точка не там");
        continue;
      }
      int? numberInFileName = int.tryParse(path.substring(start, end));
      if (numberInFileName == null) {
        print("Не число");
        continue;
      }
      poemList.addPoem(Poem(dataFile: file));
      //await poemList.readPoemFromFile(file);
    }

    if (poemList._poems.isEmpty) {
      print("Добавленно приветсвующее окно");
      poemList.addPoem(Poem(
        title: "Добро пожаловать в Cramming poems!",
        textLines: ["Вы можете добавить стихи через меню в левом верхнем углу."],
        dataFile: File("${directory.path}/0.txt"),
      ));
    }

    poemList._poems.sort((a, b) => a.nextNumberInFileName.compareTo(b.nextNumberInFileName));
    return poemList;
  }

  addPoem(Poem poem) {
    _poems.add(poem);
    selectedIndex = _poems.length - 1;
  }

  newPoem() {
    int nextNumberInFileName = (_poems.length == 0) ? 0 : (_poems.last.nextNumberInFileName);
    _selectedIndex = nextNumberInFileName;
    addPoem(Poem(
      textLines: [""],
      title: "Новый стих ${nextNumberInFileName}",
      dataFile: File("${_directory.path}/$nextNumberInFileName.txt"),
    ));
  }

  removePoemAt(int index) {
    selectedIndex -= (index <= selectedIndex) ? 1 : 0;
    _poems[index].deleteFile();
    _poems.removeAt(index);
  }

  clear(){
    for(Poem poem in _poems){
      poem.deleteFile();
    }
    _poems.clear();
    newPoem();
  }

  Poem operator [](int index){
    return _poems[index];
  }

  Poem get selectedPoem{
    return _poems[_selectedIndex];
  }

  int get length{
    return _poems.length;
  }

  set selectedIndex(newIndex) {
    // print("новый select: $newIndex");
    _selectedIndex = newIndex;
  }

  int get selectedIndex {
    return _selectedIndex;
  }

  final Directory _directory;
  late List<Poem> _poems;
  int _selectedIndex = 0; // индекс выбранного стиха
}

late PoemList poemList; // Список всех стихов
