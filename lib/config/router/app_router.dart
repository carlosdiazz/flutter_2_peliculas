import 'package:go_router/go_router.dart';

import 'package:flutter_2_cinema_app/presentation/views/views.dart';
import 'package:flutter_2_cinema_app/presentation/screens/screen.dart';

enum NamesRoutesEnum { homeScreen, movieScreen }

class NamesRoutes {
  static String homeScreen = NamesRoutesEnum.homeScreen.toString();
  static String movieScreen = NamesRoutesEnum.movieScreen.toString();
}

final appRouter = GoRouter(initialLocation: "/", routes: [
  ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                path: 'movie/:id',
                name: NamesRoutes.homeScreen,
                builder: (context, state) {
                  final movieID = state.pathParameters["id"] ?? "no-id";

                  return MovieScreen(movieId: movieID);
                },
              )
            ]),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        )
      ])

  //Rutas Padre/hijo
  //GoRoute(
  //    path: '/',
  //    name: NamesRoutes.homeScreen,
  //    builder: (context, state) => const HomeScreen(childView: HomeView()),
  //    //Esto es una subRuta
  //    routes: [
  //      GoRoute(
  //        path: 'movie/:id',
  //        name: NamesRoutes.movieScreen,
  //        builder: (context, state) {
  //          final movieId = state.pathParameters["id"] ?? "no-id";
//
  //          return MovieScreen(
  //            movieId: movieId,
  //          );
  //        },
  //      )
  //    ]),
]);
