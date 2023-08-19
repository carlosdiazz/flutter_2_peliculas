import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_2_cinema_app/domain/entities/movie.dart';
import 'package:flutter_2_cinema_app/presentation/providers/providers.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");

final searchedMoviesProvider =
    StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(
      searchMovies: movieRepository.searchMovies, ref: ref);
});

typedef SearchMoviesCallback = Future<List<Movie>> Function(
    {required String query});

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  SearchedMoviesNotifier({required this.searchMovies, required this.ref})
      : super([]);

  final SearchMoviesCallback searchMovies;
  final Ref ref;

  Future<List<Movie>> searchMoviesByQuery({required String query}) async {
    if (query.isEmpty) return [];
    final List<Movie> movies = await searchMovies(query: query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}
