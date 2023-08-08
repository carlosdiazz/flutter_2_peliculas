import 'package:flutter_riverpod/flutter_riverpod.dart';

//Propio
import 'package:flutter_2_cinema_app/domain/entities/movie.dart';
import 'package:flutter_2_cinema_app/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  //Todo para informacion persistencte
  MoviesNotifier({required this.fetchMoreMovies}) : super([]);

  MovieCallBack fetchMoreMovies;
  bool isLoading = false;
  int currentPage = 0;

  Future<void> loadNextPage() async {
    if (isLoading) return;
    print("Loanding Movie");
    isLoading = true;
    currentPage++;
    final List<Movie> movies =
        await fetchMoreMovies(page: currentPage); //todo getNowPlaying
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 800));
    isLoading = false;
  }
}
