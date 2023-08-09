import 'package:flutter_2_cinema_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_2_cinema_app/domain/entities/movie.dart';

/*EXAMPLE
{
  "1" : Movie(),
  "2" : Movie(),
  "3" : Movie(),
  "4" : Movie(),
  "5" : Movie()
}
*/

final movieDetailsProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(
      getMovie: (idMovie) => movieRepository.getMovieById(id: idMovie));
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  MovieMapNotifier({required this.getMovie}) : super({});
  final GetMovieCallback getMovie;

  Future<void> loadMovie({required String movieId}) async {
    if (state[movieId] != null) return;

    print("Realizando PEticion http");
    final movie = await getMovie(movieId);
    state = {...state, movieId: movie};
  }
}
