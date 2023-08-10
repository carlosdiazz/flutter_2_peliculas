import 'package:dio/dio.dart';

//Propio
import 'package:flutter_2_cinema_app/config/constants/environment.dart';
import 'package:flutter_2_cinema_app/domain/datasources/movies_datasource.dart';
import 'package:flutter_2_cinema_app/domain/entities/movie.dart';
import 'package:flutter_2_cinema_app/infrastructure/mappers/movie_mapper.dart';
import 'package:flutter_2_cinema_app/infrastructure/models/moviedb/movie_details.dart';
import 'package:flutter_2_cinema_app/infrastructure/models/moviedb/moviedb_response.dart';

class MovieDbDataSourceImpl extends MoviesDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        "api_key": Environment.theMovieDbKey,
        "language": "ex-MX"
      }));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDbResponse.results
        .where((movieDb) => movieDb.posterPath != 'no-poster')
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get('/movie/now_playing', queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get('/movie/popular', queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) async {
    final response =
        await dio.get("/movie/upcoming", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get("/movie/top_rated", queryParameters: {"page": page});
    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById({required String id}) async {
    final response = await dio.get("/movie/$id");
    if (response.statusCode != 200) {
      throw Exception("No existe este Id => $id");
    }

    final movieDb = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDb);
    return movie;
  }

  @override
  Future<List<Movie>> searchMovies({required String query}) async {
    final response =
        await dio.get("/search/movie", queryParameters: {"query": query});
    return _jsonToMovies(response.data);
  }
}
