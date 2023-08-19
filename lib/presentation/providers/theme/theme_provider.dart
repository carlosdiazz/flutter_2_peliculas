import 'package:flutter_2_cinema_app/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, AppThemeCustom>(
        (ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<AppThemeCustom> {
  ThemeNotifier() : super(AppThemeCustom());

  void toggleDarkMode() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith(selectColor: colorIndex);
  }
}
