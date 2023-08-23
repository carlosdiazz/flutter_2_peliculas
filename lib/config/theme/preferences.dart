import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool _isDarkMode = false;
  static int _selectColorInt = 0;

  //Inicio el Prefrences
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isDarkMode {
    return _prefs.getBool('isDarkMode') ?? _isDarkMode;
  }

  static set isDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    _prefs.setBool('isDarkMode', isDarkMode);
  }

  static int get selectColorInt {
    return _prefs.getInt("selectColor") ?? _selectColorInt;
  }

  static set selectColorInt(int selectColor) {
    _selectColorInt = selectColor;
    _prefs.setInt("selectColor", selectColor);
  }
}
