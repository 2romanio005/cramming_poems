// TODO можешь поманять на PoemData если надо, но вроде так красивее
class Poem {
  Poem({required List<String> original, required String title, required int numberInFileName}) {
    // TODO создание различный типов вывода
    _differentTypesOfPoem = [];
    _differentTypesOfPoem.add(original);  // добавили оригинал

    this.title = title; // обязательно после записи  _differentTypesOfPoem, т.к может взять первую строку в качестве названия
    _numberInFileName = numberInFileName;
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

  int get numberInFileName{
    return _numberInFileName;
  }

  List<List<String>> get differentTypesOfPoem{
    return _differentTypesOfPoem;
  }

  late int _numberInFileName;
  late String _title; // название стиха
  late List<List<String>> _differentTypesOfPoem; // массив типов отобажения стихов где каждый тип стиха хранится построчно [0] - пусть буде оригинал [1] - только первые буквы и т.д
}
