import 'package:flutter/material.dart';

//Propio
import 'package:flutter_2_cinema_app/presentation/views/views.dart';
import 'package:flutter_2_cinema_app/presentation/widgets/widggets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.childView});

  final Widget childView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: HomeView(),
      body: childView,
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
