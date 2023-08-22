import 'package:flutter_2_cinema_app/domain/datasources/movies_datasource.dart';
import 'package:flutter_2_cinema_app/domain/entities/movie.dart';
import 'package:flutter_2_cinema_app/domain/entities/video.dart';
import 'package:flutter_2_cinema_app/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return datasource.getUpComing(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<Movie> getMovieById({required String id}) {
    return datasource.getMovieById(id: id);
  }

  @override
  Future<List<Movie>> searchMovies({required String query}) {
    return datasource.searchMovies(query: query);
  }

  @override
  Future<List<Movie>> getSimilarMovies({required int movieID}) {
    return datasource.getSimilarMovies(movieID: movieID);
  }

  @override
  Future<List<Video>> getYoutubeVideosById({required int movieId}) {
    return datasource.getYoutubeVideosById(movieId: movieId);
  }
}
