// все цвета объявляем сдесь, они ведь общие
// все названия начинаем со слова 'Color' и пишем за что он отвечает, чтобы не запутаться
import 'package:flutter/material.dart';

// Палитра основных цветов используются только внутри этого файла
// Создаём их копию с более понятным названием и использовать уже ёё
Color ColorMain1 = Color.fromARGB(255, 47, 27, 126);
Color ColorMain2 = Color.fromARGB(255, 236, 234, 255);
// все это надо когда начнём переделывать дизайн.

Color ColorBackground = ColorMain2;             // задний фон приложения
Color ColorFont = ColorMain1;                   // шрифта
Color ColorHeader = ColorMain1;