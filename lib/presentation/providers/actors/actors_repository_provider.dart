import 'package:flutter_2_cinema_app/infrastructure/datasources/actor_moviedb_datasource_impl.dart';
import 'package:flutter_2_cinema_app/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositorio es inmutable
final actorsRepositoryProvider = Provider((ref) {
  //Cambiar aqui el datasource
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});
