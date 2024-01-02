// TODO можешь поманять на PoemData если надо, но вроде так красивее
class Poem {
  late String _title; // название стиха
  // TODO выбирай как удобнее
  //late List<String> _differentTypesOfPoem;        // массив где каждый вид стиха хранится в виде одной строки [0] - пусть буде оригинал [1] - только первые буквы и т.д
  late List<List<String>> _differentTypesOfPoem; // массив где каждый вид стиха хранится построчно [0] - пусть буде оригинал [1] - только первые буквы и т.д

  Poem({required String original, required String title}) {
    // TODO создание различный типов вывода
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

// TODO хз может не надо выносить в отдельный файл? вынеси сам если хочешь
// всё взаимодейстиве со списком стихов
class PoemList {
  List<Poem> _poems = [
    // FIXME это для проверки отображения
    Poem(
      original: "я лучше всех\nвторая строка",
      title: "название",
    ),
    Poem(
      original: "без названия",
      title: "",
    ),
    Poem(
      original: "днинное оооооочень длинное название",
      title: "",
    ),
  ];
  int _selectedIndex = 0; // индекс выбранного стиха

  List<Poem> get poems {
    return _poems;
  }

  addPoem() {
    poems.add(Poem(original: "", title: "Новый стих ${poems.length}"));
    selectedIndex = poems.length - 1;
  }

  removePoemAt(int index) {
    selectedIndex -= (index <= selectedIndex) ? 1 : 0;
    poems.removeAt(index);
  }

  set selectedIndex(newIndex) {
    // print("новый select: $newIndex");
    _selectedIndex = newIndex;
  }

  int get selectedIndex {
    return _selectedIndex;
  }
}

PoemList poemList = PoemList(); // Список всех стихов
