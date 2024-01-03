import 'package:cramming_poems/Data/poem.dart';

import 'dart:io';
import 'package:path_provider/path_provider.dart';

// всё взаимодейстиве со списком стихов
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
    final directory = await getApplicationDocumentsDirectory();
    PoemList poemList = PoemList._(directory);

    final List<FileSystemEntity> entities = await directory.list(recursive: false).toList();
    final Iterable<File> files = entities.whereType<File>();
    for (File file in files) {
      print("Чтение файла: ${file.path}");
      await poemList.readPoemFromFile(file);
    }

    if (poemList.poems.isEmpty) {
      print("Добавленна заглушка");
      poemList.addPoem(Poem(
        title: "Добро пожаловать в Cramming poems!",
        original: ["Вы можете добавить стихи через меню в левом верхнем углу."],
        numberInFileName: -1,
      ));
    }
    print("Всё считанно");

    return poemList;
  }

  addPoem(Poem poem) {
    poems.add(poem);
    selectedIndex = poems.length - 1;
  }

  newPoem() {
    int numberInFileName = (_poems.length == 0) ? 0 : (_poems.last.numberInFileName + 1);
    addPoem(Poem(
      original: [""],
      title: "Новый стих ${numberInFileName}",
      numberInFileName: numberInFileName,
    ));
  }

  // TODO возможно уботь async если не будет использоваться
  Future<void> readPoemFromFile(File file) async {
    String path = file.path;
    int start = path.lastIndexOf('/');
    int end = path.lastIndexOf('.');
    if(end <= start){
      print("Точка не там");
      return;
    }
    int? numberInFileName = int.tryParse(path.substring(start, end));
    if(numberInFileName == null){
      print("Не число");
      return;
    }
    List<String> content = file.readAsStringSync().split('\n');
    if (content.isEmpty) {
      print("Пустой");
      return;
    }
    print("Читаю");
    String title = content.last; // отделяем название из последней строки
    content.removeLast(); // удаляем название из основного текста
    addPoem(Poem(
      original: content,
      title: title,
      numberInFileName: numberInFileName, // получаем номер файла из его названия
    ));
  }

  Future<void> writePoemInFile(Poem poem) async {
    File file = File("${_directory.path}/${poem.numberInFileName}.txt");

    file.writeAsString("${poem.differentTypesOfPoem[0].join()}\n${poem.title}"); // записываем в файл оригинал текста и в конце - название
  }

  removePoemAt(int index) {
    selectedIndex -= (index <= selectedIndex) ? 1 : 0;
    _poems.removeAt(index);
  }

  List<Poem> get poems {
    return _poems;
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
