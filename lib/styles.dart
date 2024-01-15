import 'package:flutter/material.dart';
import 'package:cramming_poems/colors.dart';

ButtonStyle buttonStyleOFF = IconButton.styleFrom(
  backgroundColor: ColorButtonBackground,
  hoverColor: ColorButtonHover,
  foregroundColor: ColorButtonForeground,
  highlightColor: ColorButtonPressedOFF,
);

ButtonStyle buttonStyleOK = IconButton.styleFrom(
  backgroundColor: ColorButtonBackground,
  hoverColor: ColorButtonHover,
  foregroundColor: ColorButtonForeground,
  highlightColor: ColorButtonPressedOK,
);

ButtonStyle buttonStyleDefault = IconButton.styleFrom(
  backgroundColor: ColorButtonBackground,
  hoverColor: ColorButtonHover,
  foregroundColor: ColorButtonForeground,
);

// TODO перенеси свои стили, а то я боюсь их трогать