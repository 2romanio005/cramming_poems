import 'dart:io';
import 'package:path_provider/path_provider.dart';


import 'package:cramming_poems/Data/poem.dart';
import 'package:cramming_poems/Data/poemFile.dart';

class PoemList {
  PoemList._(this._directory) {
    _listPoemFile = [];
    _selectedPoemDisplayType = PoemDisplayType.original;
  }

  // вместо конструктора чтобы использовать await
  static Future<PoemList> create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    directory = await Directory("${directory.path}/savedPoems").create(recursive: true);
    PoemList createdPemList = PoemList._(directory);

    final List<FileSystemEntity> entities = await directory.list(recursive: false).toList();
    final Iterable<File> files = entities.whereType<File>();
    //files.forEach(print);
    for (File file in files) {
      //print("Чтение файла: ${file.path}");
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
      createdPemList.addPoemFile(PoemFile(
        poem: Poem(
          title: "Reading error",  // будет перезаписано из файла, или останется если произойдёт ошибка чтения
        ),
        dataFile: file,
      ));
      //await createdPemList.readPoemFromFile(file);
    }
    print("Всё ститано");
    if (createdPemList._listPoemFile.isEmpty) {
      print("Добавленно приветсвующее окно");
      createdPemList.addPoemFile(PoemFile(
        poem: Poem(
          text: ["Вы можете добавить стихи через меню в левом верхнем углу."],
          title: "Добро пожаловать в Cramming poems!", // будет перезаписано из файла, или останется если произойдёт ошибка чтения
        ),
        dataFile: File("${directory.path}/0.txt"),
      ));
    }
    createdPemList._listPoemFile.sort((a, b) => a.nextNumberInFileName.compareTo(b.nextNumberInFileName));
    return createdPemList;
  }

  addPoemFile(PoemFile poemFile) {
    _listPoemFile.add(poemFile);
    selectedPoemIndex = _listPoemFile.length - 1;
  }

  newPoemFile() {
    int nextNumberInFileName = (_listPoemFile.isEmpty) ? 0 : (_listPoemFile.last.nextNumberInFileName);
    _selectedPoemIndex = nextNumberInFileName;
    addPoemFile(PoemFile(
      poem: Poem(
        text: [""],
        title: "Новый стих $nextNumberInFileName",
      ),
      dataFile: File("${_directory.path}/$nextNumberInFileName.txt"),
    ));
  }

  removePoemAt(int index) {
    _selectedPoemIndex -= (index <= _selectedPoemIndex) ? 1 : 0;
    _listPoemFile[index].deleteFile();
    _listPoemFile.removeAt(index);

    if (_listPoemFile.isEmpty) {
      newPoemFile();
    }
  }

  clear(){
    for(PoemFile poem in _listPoemFile){
      poem.deleteFile();
    }
    _listPoemFile.clear();
    newPoemFile();
  }

  PoemFile operator [](int index){
    return _listPoemFile[index];
  }

  PoemFile get selectedPoemFile{
    return _listPoemFile[_selectedPoemIndex];
  }

  Poem get selectedPoem{
    return _listPoemFile[_selectedPoemIndex].poem;
  }

  set selectedPoem(Poem newPoem){
    _listPoemFile[_selectedPoemIndex].poem = newPoem;
  }

  List<String> get selectedFormatText{
    return selectedPoem.getFormattedText(_selectedPoemDisplayType);
  }

  int get length{
    return _listPoemFile.length;
  }

  set selectedPoemIndex(int newPoemIndex) {
    // print("новый select: newPoemIndex");
    _selectedPoemIndex = newPoemIndex;
  }

  int get selectedPoemIndex {
    return _selectedPoemIndex;
  }

  set selectedPoemDisplayType(newSelectedPoemDisplayType) {
    // print("новый DisplayType: newSelectedPoemDisplayType");
    _selectedPoemDisplayType = newSelectedPoemDisplayType;
  }

  PoemDisplayType get selectedPoemDisplayType {
    return _selectedPoemDisplayType;
  }

  final Directory _directory;
  late List<PoemFile> _listPoemFile;
  int _selectedPoemIndex = 0; // индекс выбранного стиха
  late PoemDisplayType _selectedPoemDisplayType;  // выбранный тип отображения
}

late PoemList poemList; // Список всех стихов


