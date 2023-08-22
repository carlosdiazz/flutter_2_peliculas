import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key, required this.currentChild});
  final StatefulNavigationShell currentChild;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
        currentIndex: currentChild.currentIndex,
        selectedIconTheme: IconThemeData(color: colors.primary),
        //selectedLabelStyle: TextStyle(color: colors.primary),
        selectedItemColor: colors.primary,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedItemColor: colors.secondary,
        onTap: (value) => currentChild.goBranch(value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Populares",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: "Favoritos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_applications), label: "Settings"),
          //BottomNavigationBarItem(
          //    icon: Icon(Icons.settings), label: "Configuracion")
        ]);
  }
}
