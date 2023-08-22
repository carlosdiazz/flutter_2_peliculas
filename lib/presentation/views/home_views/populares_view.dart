import 'package:flutter/material.dart';
import 'package:flutter_2_cinema_app/presentation/providers/providers.dart';
import 'package:flutter_2_cinema_app/presentation/widgets/widggets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularesView extends ConsumerWidget {
  const PopularesView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final popularMovies = ref.watch(popularMoviesProvider);

    if (popularMovies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      body: MovieMansory(
        loadNextPage: () =>
            ref.read(popularMoviesProvider.notifier).loadNextPage(),
        movies: popularMovies,
      ),
    );
  }
}
