import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'drift_database.g.dart';

class DriftMovieTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isAdult => boolean()();
  BoolColumn get isCached => boolean()();
  BoolColumn get isFavorite => boolean()();
  DateTimeColumn get releaseDate => dateTime().nullable()();
  RealColumn get rating => real()();
  IntColumn get voteCount => integer()();
  TextColumn get genres => text()();
  TextColumn get backdropPath => text()();
  TextColumn get originalLanguage => text()();
  TextColumn get originalTitle => text()();
  TextColumn get overview => text()();
  TextColumn get posterPath => text()();
  TextColumn get source => text()();
  TextColumn get sourceId => text()();
  TextColumn get title => text()();
}

@DriftDatabase(tables: [DriftMovieTable])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  static QueryExecutor openConnection() {
    return driftDatabase(
      name: 'drift_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
