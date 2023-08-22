import 'package:flutter/material.dart';
import 'package:flutter_2_cinema_app/domain/entities/movie.dart';
import 'package:flutter_2_cinema_app/presentation/providers/providers.dart';
import 'package:flutter_2_cinema_app/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final similarMoviesProvider = FutureProvider.family((ref, int movieID) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getSimilarMovies(movieID: movieID);
});

class SimilarMovies extends ConsumerWidget {
  const SimilarMovies({super.key, required this.movieId});
  final int movieId;

  @override
  Widget build(BuildContext context, ref) {
    final similarMoviesFuture = ref.watch(similarMoviesProvider(movieId));

    return similarMoviesFuture.when(
      data: (data) => _Recomendaciones(movies: data),
      error: (_, __) =>
          const Center(child: Text('No se pudo cargar películas similares')),
      loading: (() => const Center(child: CircularProgressIndicator())),
    );
  }
}

class _Recomendaciones extends StatelessWidget {
  const _Recomendaciones({required this.movies});
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return const SizedBox();
    return Container(
      margin: const EdgeInsetsDirectional.only(bottom: 50),
      child: MovieHorizontalListview(
        title: "Recomendaciones",
        movies: movies,
      ),
    );
  }
}
