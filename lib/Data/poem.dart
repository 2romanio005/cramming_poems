import 'dart:io';

class Poem {
  Poem({List<String> original = const [""], String title = "", required File dataFile}) {
    // print("Новый стих");
    _dataFile = dataFile;
    String path = _dataFile.path;
    _nextNumberInFileName = int.parse(path.substring(path.lastIndexOf('/') + 1, path.lastIndexOf('.'))) + 1;

    _differentTypesOfPoem = [];
    _differentTypesOfPoem.add(original); // добавили оригинал

    this.title = title; // обязательно после записи  _differentTypesOfPoem, т.к может взять первую строку в качестве названия

    // если файл существует то надо читать с него, а если отсутсвует то создать его и сохраниться в нем
    if (dataFile.existsSync()) {
      _readFromFile();
    } else {
      writeInFile();
    }

    // TODO тут надо дозаполнить массив _differentTypesOfPoem различными выидами отображения
  }

  //Future<void> readFromFile() async {
  void _readFromFile() {
    try {
      String tmp = _dataFile.readAsStringSync();
      List<String> content = tmp.split('\n');
      print("Считано ${content.length}: " + tmp);
      String newTitle = content.last; // отделяем название из последней строки

      content.removeLast(); // удаляем название из основного текста
      _differentTypesOfPoem[0] = content; // прочитали оригинал
      title = newTitle; // обязательно после запис оргинала
      //print("title: " + title);
    } catch (error) {
      print(error);
    }
  }

  Future<void> writeInFile() async {
    _dataFile.writeAsString("${_differentTypesOfPoem[0].join()}\n$_title"); // записываем в файл оригинал текста и в конце - название
  }

  void deleteFile(){
    _dataFile.deleteSync();
  }

  int get nextNumberInFileName {
    return _nextNumberInFileName;
  }

  set title(String newTitle) {
    if (newTitle.isEmpty) {
      _title = _differentTypesOfPoem[0][0]; // TODO надо взять первую строчку стиха, если название не написано
    } else {
      _title = newTitle;
    }
  }

  String get title {
    return _title;
  }

  List<String> operator [](int index){
    return _differentTypesOfPoem[index];
  }


  late File _dataFile;
  late final int _nextNumberInFileName;
  late String _title; // название стиха
  // если неудобно, то можно передалть на хранение каждого вида стиха в виде одной строки
  late List<List<String>> _differentTypesOfPoem; // массив типов отобажения стихов где каждый тип стиха хранится построчно [0] - пусть буде оригинал [1] - только первые буквы и т.д
}
