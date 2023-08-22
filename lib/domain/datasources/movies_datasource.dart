import 'package:flutter_2_cinema_app/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpComing({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<Movie> getMovieById({required String id});

  Future<List<Movie>> searchMovies({required String query});

  Future<List<Movie>> getSimilarMovies({required int movieID});
}
