import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2_cinema_app/presentation/widgets/widggets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Providers
import 'package:flutter_2_cinema_app/presentation/providers/storage/favorites_movies_provider.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    //ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    if (movies.isEmpty) {
      isLastPage = true;
    }

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    //final favoritesMovies = ref.watch(favoriteMoviesProvider);
    final favoritesMovies = ref.watch(favoriteMoviesProvider).values.toList();
    final colors = Theme.of(context).colorScheme;

    if (favoritesMovies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spin(
              //duration: const Duration(seconds: 1),
              //spins: 10,
              infinite: true,
              child: Icon(
                Icons.favorite_border_outlined,
                size: 60,
                color: colors.primary,
              ),
            ),
            Text(
              "Ohhh noo!!",
              style: TextStyle(fontSize: 20, color: colors.primary),
            ),
            Text(
              "No tienes peliculas en favoritos.",
              style: TextStyle(fontSize: 15, color: colors.secondary),
            ),
            const SizedBox(
              height: 100,
            ),
            FilledButton.tonal(
                onPressed: () => context.go("/"),
                child: const Text("Empieza a Buscar"))
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorites View"),
          centerTitle: true,
        ),
        body: MovieMansory(
          movies: favoritesMovies,
          loadNextPage: loadNextPage,
        ));
  }
}
