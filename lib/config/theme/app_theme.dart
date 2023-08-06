import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.red,
  Colors.yellow,
  Colors.green,
  Colors.purple,
  Colors.indigo,
  Colors.teal
];

class AppThemeCustom {
  final int selectColor;
  final bool isDarkMode;

  AppThemeCustom({this.isDarkMode = true, this.selectColor = 0})
      : assert(selectColor >= 0, "El indice de color no puede ser menor que 0"),
        assert(selectColor < colorList.length,
            "El índice de color está fuera del rango permitido");

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colorList[selectColor]);
}
