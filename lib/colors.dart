// все цвета объявляем сдесь, они ведь общие
// все названия начинаем со слова 'Color' и пишем за что он отвечает, чтобы не запутаться
import 'package:flutter/material.dart';

// Палитра основных цветов используются только внутри этого файла
// Создаём их копию с более понятным названием и использовать уже ёё
Color ColorMain1 = Color.fromARGB(255, 47, 27, 126);
Color ColorMain2 = Color.fromARGB(255, 236, 234, 255);
Color ColorMain3 = Color.fromARGB(255, 200, 200, 200);
Color ColorMain4 = Color.fromARGB(255, 0, 180, 0);
Color ColorMain5 = Color.fromARGB(255, 180, 0, 0);
// все это надо когда начнём переделывать дизайн.

Color ColorBackground = ColorMain2;             // задний фон приложения
Color ColorFont = ColorMain1;                   // шрифта
Color ColorHeader = ColorMain1;                 // зоголовки
Color ColorPrimary = ColorMain1;                // FIXME TODO где коментарий, что это???


// цвета для кнопок
Color ColorButtonBackground = ColorMain3;       // задний фон
Color ColorButtonHover = ColorMain2;            // при наведении мыши
Color ColorButtonForeground = ColorMain1;       // сама иконка или текс
Color ColorButtonPressedOK = ColorMain4;        // при нажатии на кнопку "да"
Color ColorButtonPressedOFF = ColorMain5;       // при нажатии на кнопку "нет"


// FIXME удалить цвета для тестирования
Color ColorTmpR = Color.fromARGB(255, 255, 0, 0);
Color ColorTmpG = Color.fromARGB(255, 0, 255, 0);
Color ColorTmpB = Color.fromARGB(255, 0, 0, 255);

