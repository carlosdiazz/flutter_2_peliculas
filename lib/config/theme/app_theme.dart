import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.red,
  Colors.purple,
  Colors.indigo,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.greenAccent,
  Colors.amber,
  Colors.indigo,
];

class AppThemeCustom {
  final int selectColor;
  final bool isDarkMode;

  AppThemeCustom copyWith({int? selectColor, bool? isDarkMode}) =>
      AppThemeCustom(
          selectColor: selectColor ?? this.selectColor,
          isDarkMode: isDarkMode ?? this.isDarkMode);

  AppThemeCustom({this.isDarkMode = true, this.selectColor = 1})
      : assert(selectColor >= 0, "El indice de color no puede ser menor que 0"),
        assert(selectColor < colorList.length,
            "El índice de color está fuera del rango permitido");

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      colorSchemeSeed: colorList[selectColor],
      appBarTheme: const AppBarTheme(centerTitle: false));
}
