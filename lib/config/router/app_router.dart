import 'package:go_router/go_router.dart';

import 'package:flutter_2_cinema_app/presentation/views/views.dart';
import 'package:flutter_2_cinema_app/presentation/screens/screen.dart';

enum NamesRoutesEnum { homeScreen, movieScreen, settingsScreen }

class NamesRoutes {
  static String homeScreen = NamesRoutesEnum.homeScreen.toString();
  static String movieScreen = NamesRoutesEnum.movieScreen.toString();
  static String settingsScreen = NamesRoutes.settingsScreen.toString();
}

final appRouter = GoRouter(initialLocation: "/", routes: [
  StatefulShellRoute.indexedStack(
      builder: (_, __, child) {
        return HomeScreen(childView: child);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(routes: [
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
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/categories',
            builder: (context, state) {
              return const CategoriesView();
            },
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/favorites',
            builder: (context, state) {
              return const FavoritesView();
            },
          )
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/settings',
            builder: (context, state) {
              return const SettingsView();
            },
          )
        ])
      ])
]);


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