import 'package:get_it/get_it.dart';
import 'package:movie_mite/core/database/drift_database.dart';

void setupDatabase() {
  GetIt.I.registerLazySingleton<AppDatabase>(() => AppDatabase());
}
