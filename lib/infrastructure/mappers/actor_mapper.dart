import 'package:flutter_2_cinema_app/domain/entities/actor.dart';
import 'package:flutter_2_cinema_app/infrastructure/models/moviedb/credits_response.dart';

class ActorMapper {
  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
          ? "https://image.tmdb.org/t/p/w500${cast.profilePath}"
          : "https://otoa-website.s3.us-east-2.amazonaws.com/profiles/no-image.png",
      character: cast.character);
}
