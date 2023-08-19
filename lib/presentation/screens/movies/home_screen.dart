import 'package:flutter/material.dart';

//Propio
import 'package:flutter_2_cinema_app/presentation/widgets/widggets.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.childView});

  final StatefulNavigationShell childView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: HomeView(),
      body: childView,
      bottomNavigationBar: CustomBottomNavigation(currentChild: childView),
    );
  }
}
