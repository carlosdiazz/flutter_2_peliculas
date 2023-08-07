import 'package:flutter_2_cinema_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:flutter_2_cinema_app/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieRepositoryProvider = Provider((ref) {
  //Cambiar aqui para usar otra api
  return MovieRepositoryImpl(MovieDbDataSource());
});
