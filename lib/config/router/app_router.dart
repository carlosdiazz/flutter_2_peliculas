import 'package:go_router/go_router.dart';
import 'package:flutter_2_cinema_app/presentation/screens/screen.dart';

enum NamesRoutesEnum { homeScreen, movieScreen }

class NamesRoutes {
  static String homeScreen = NamesRoutesEnum.homeScreen.toString();
  static String movieScreen = NamesRoutesEnum.movieScreen.toString();
}

final appRouter = GoRouter(initialLocation: "/", routes: [
  GoRoute(
      path: '/',
      name: NamesRoutes.homeScreen,
      builder: (context, state) => const HomeScreen(),
      //Esto es una subRuta
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: NamesRoutes.movieScreen,
          builder: (context, state) {
            final movieId = state.pathParameters["id"] ?? "no-id";

            return MovieScreen(
              movieId: movieId,
            );
          },
        )
      ]),
]);
