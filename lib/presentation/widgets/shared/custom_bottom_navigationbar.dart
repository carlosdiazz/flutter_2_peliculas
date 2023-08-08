import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: colors.primary),
        unselectedItemColor: colors.secondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_max),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.label_outline), label: "Categorias"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: "Favoritos"),
          //BottomNavigationBarItem(
          //    icon: Icon(Icons.settings), label: "Configuracion")
        ]);
  }
}
