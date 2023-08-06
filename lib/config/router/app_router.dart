import 'package:flutter_2_cinema_app/presentation/screens/screen.dart';
import 'package:go_router/go_router.dart';

enum NamesRoutes { homeScreen }

final appRouter = GoRouter(initialLocation: "/", routes: [
  GoRoute(
    path: '/',
    name: NamesRoutes.homeScreen.toString(),
    builder: (context, state) => const HomeScreen(),
  )
]);
