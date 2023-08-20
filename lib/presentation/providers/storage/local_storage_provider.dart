import 'package:flutter_riverpod/flutter_riverpod.dart';

//Propio
import 'package:flutter_2_cinema_app/infrastructure/datasources/isar_datasource.dart';
import 'package:flutter_2_cinema_app/infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(datasource: IsarDatasource());
});
