// TODO можешь поманять на PoemData если надо, но вроде так красивее
class Poem {
  late String _title; // название стиха
  // TODO выбирай как удобнее
  //late List<String> _differentTypesOfPoem;        // массив где каждый вид стиха хранится в виде одной строки [0] - пусть буде оригинал [1] - только первые буквы и т.д
  late List<List<String>> _differentTypesOfPoem; // массив где каждый вид стиха хранится построчно [0] - пусть буде оригинал [1] - только первые буквы и т.д

  Poem({required String original, required String title}) {
    // создание различный типов вывода
    _differentTypesOfPoem = [];
    _differentTypesOfPoem.add([original]);

    this.title = title; // обязательно после записи  _differentTypesOfPoem
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
}
