import 'package:flutter_riverpod/flutter_riverpod.dart';

//Propio
import 'package:flutter_2_cinema_app/config/theme/app_theme.dart';
import 'package:flutter_2_cinema_app/config/theme/preferences.dart';

//Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppThemeCustom>(
        (ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<AppThemeCustom> {
  ThemeNotifier() : super(AppThemeCustom(isDarkMode: true, selectColor: 0)) {
    _loadThemeFromPrefs();
  }

  // Cargar tema guardado desde SharedPreferences
  Future<void> _loadThemeFromPrefs() async {
    await Preferences.init();
    final isDarkMode = Preferences.isDarkMode;
    final selectColor = Preferences.selectColorInt;

    state = AppThemeCustom(isDarkMode: isDarkMode, selectColor: selectColor);
  }

  // Guardar el estado actual en SharedPreferences
  Future<void> _saveThemeToPrefs() async {
    await Preferences.init();
    Preferences.isDarkMode = state.isDarkMode;
    Preferences.selectColorInt = state.selectColor;
  }

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
    _saveThemeToPrefs(); // Guardar el cambio en SharedPreferences
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectColor: colorIndex);
    _saveThemeToPrefs(); // Guardar el cambio en SharedPreferences
  }
}
