import 'package:dio/dio.dart';

//Propio
import 'package:flutter_2_cinema_app/config/constants/environment.dart';
import 'package:flutter_2_cinema_app/domain/datasources/actors_datasource.dart';
import 'package:flutter_2_cinema_app/domain/entities/actor.dart';
import 'package:flutter_2_cinema_app/infrastructure/mappers/actor_mapper.dart';
import 'package:flutter_2_cinema_app/infrastructure/models/moviedb/credits_response.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        "api_key": Environment.theMovieDbKey,
        "language": "es-MX"
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get("/movie/$movieId/credits");
    final creditsMovieDbResponse = CreditsResponse.fromJson(response.data);

    final actors = creditsMovieDbResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();
    return actors;
  }
}
