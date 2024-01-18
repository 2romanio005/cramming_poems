import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:cramming_poems/Data/poem.dart';
import 'package:cramming_poems/Data/poemFile.dart';

class PoemList {
  PoemList._({required Directory directory, required File dataFile}) {
    _listPoemFile = [];
    _directory = directory;
    _dataFile = dataFile;

    _selectedPoemIndex = 0;
    _selectedPoemDisplayType = PoemDisplayType.original;
    if (_dataFile.existsSync()) {
      _readFromFile();
    } else {
      _writeInFile();
    }
  }

  // вместо конструктора чтобы использовать await
  static Future<PoemList> create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    File dataFile = File("${directory.path}/dataPoemList.txt");

    directory = await Directory("${directory.path}/savedPoems").create(recursive: true);
    PoemList createdPoemList = PoemList._(directory: directory, dataFile: dataFile);

    final List<FileSystemEntity> entities = await directory.list(recursive: false).toList();
    final Iterable<File> files = entities.whereType<File>();
    //files.forEach(print);
    for (File file in files) {
      //print("Чтение файла: ${file.path}");
      String path = file.path;
      int start = path.lastIndexOf('/') + 1;
      int end = path.lastIndexOf('.');
      if (end <= start) {
        //print("Точка не там");
        continue;
      }
      int? numberInFileName = int.tryParse(path.substring(start, end));
      if (numberInFileName == null) {
        //print("Не число");
        continue;
      }
      createdPoemList._listPoemFile.add(PoemFile(
        poem: Poem(
          title: "Reading error", // будет перезаписано из файла, или останется если произойдёт ошибка чтения
        ),
        dataFile: file,
      ));
      //await createdPoemList.readPoemFromFile(file);
    }

    if (createdPoemList._listPoemFile.isEmpty) {
      createdPoemList._listPoemFile.add(PoemFile(
        // чтобы не перезаписывать индекс выбранного стиха в память кучу раз
        poem: Poem(
          text: ["\tВы можете добавить стихи по кнопке '+' через меню в левом верхнем углу (три полосочки)",
            "и выбрать способ отображения через меню в правом верхнем углу (стрелочка вниз)",
            "",
            "Почта для багов и предложений (не писать о мелочах) spamakk862@gmail.com",
            "",
            "",
            "",
            "  (\\ ",
            "  \\'\\ ",
            "  \\\'\\     __________  ",
            "   / '|   ()_________)",
            "   \\ '/    \\ ~~~~~~~~ \\",
            "     \\       \\ ~~~~~~   \\",
            "     ==).      \\__________\\",
            "    (__)       ()__________)",
            "",
            "",
            "",
            "",
            "",
            "От двух Улиточек!\t2024 год."
          ],
          // "(¯`O´¯)",
          // "*./ | \\ .*",
          // "..*♫*.",
          //   ", • '*♥* ' • ,",
          //   ". '*• ♫♫♫•*'",
          //   ".. ' *, • '♫ ' • ,* \'",
          //   ".' * • ♫*♥*♫• * '",
          //   "* • С_Новым'•  * '",
          //   ".* ' •♫♫*♥*♫♫ • ' * '",
          //   "' ' • Годом . • ' ' '",
          //   "' ' • ♫♫♫*♥*♫♫♫• * ' '",
          //   "..x♥x"

          title: "Добро пожаловать в Cramming poems!", // будет перезаписано из файла, или останется если произойдёт ошибка чтения
        ),
        dataFile: File("${directory.path}/0.txt"),
      ));
    }
    createdPoemList._listPoemFile.sort((a, b) => a.nextNumberInFileName.compareTo(b.nextNumberInFileName));

    return createdPoemList;
  }

  addPoemFile(PoemFile poemFile) {
    _listPoemFile.add(poemFile);
    selectedPoemIndex = _listPoemFile.length - 1;
  }

  newPoemFile() {
    int nextNumberInFileName = (_listPoemFile.isEmpty) ? 0 : (_listPoemFile.last.nextNumberInFileName);
    selectedPoemIndex = nextNumberInFileName;
    addPoemFile(PoemFile(
      poem: Poem(
        title: "Новый стих $nextNumberInFileName",
      ),
      dataFile: File("${_directory.path}/$nextNumberInFileName.txt"),
    ));
  }

  removePoemAt(int index) {
    selectedPoemIndex -= (index <= _selectedPoemIndex) ? 1 : 0;
    _listPoemFile[index].deleteFile();
    _listPoemFile.removeAt(index);

    if (_listPoemFile.isEmpty) {
      newPoemFile();
    }
  }

  clear() {
    for (PoemFile poem in _listPoemFile) {
      poem.deleteFile();
    }
    _listPoemFile.clear();
    newPoemFile();
  }

  PoemFile operator [](int index) {
    return _listPoemFile[index];
  }

  PoemFile get selectedPoemFile {
    return _listPoemFile[_selectedPoemIndex];
  }

  Poem get selectedPoem {
    return _listPoemFile[_selectedPoemIndex].poem;
  }

  set selectedPoem(Poem newPoem) {
    _listPoemFile[_selectedPoemIndex].poem = newPoem;
  }

  List<String> get selectedFormatText {
    return selectedPoem.getFormattedText(_selectedPoemDisplayType);
  }

  int get length {
    return _listPoemFile.length;
  }

  set selectedPoemIndex(int newPoemIndex) {
    // print("новый select: newPoemIndex");
    _selectedPoemIndex = newPoemIndex;
    _writeInFile();
  }

  int get selectedPoemIndex {
    return _selectedPoemIndex;
  }

  set selectedPoemDisplayType(newSelectedPoemDisplayType) {
    // print("новый DisplayType: newSelectedPoemDisplayType");
    _selectedPoemDisplayType = newSelectedPoemDisplayType;
    _writeInFile();
  }

  PoemDisplayType get selectedPoemDisplayType {
    return _selectedPoemDisplayType;
  }

  void _writeInFile() async {
    try {
      //print("Writing: ${_dataFile.path}");
      _dataFile.writeAsString("$_selectedPoemIndex\n${_selectedPoemDisplayType.index}");
    } catch (error) {
      print(error);
    }
  }

  void _readFromFile() {
    try {
      //print("Reading: ${_dataFile.path}");
      List<String> content = _dataFile.readAsLinesSync();
      _selectedPoemIndex = int.parse(content[0]); // запись индекса выбранного стиаха
      _selectedPoemDisplayType = PoemDisplayType.values[int.parse(content[1])]; // запись выбраного отображения
    } catch (error) {
      print(error);
    }
  }

  late final Directory _directory;
  late List<PoemFile> _listPoemFile;
  late int _selectedPoemIndex; // индекс выбранного стиха
  late PoemDisplayType _selectedPoemDisplayType; // выбранный тип отображения

  late final File _dataFile;
}

late PoemList poemList; // Список всех стихов
