import 'package:drift/drift.dart' as drift;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_mite/core/database/drift_database.dart';
import 'package:movie_mite/features/movie/data/datasources/favorite_datasource.dart';
import 'package:movie_mite/features/movie/data/models/drift_movie_model.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('FavoriteDatasource', () {
    late AppDatabase db;
    late FavoriteDatasource datasource;

    setUp(() async {
      db = AppDatabase(
        drift.DatabaseConnection(
          NativeDatabase.memory(),
          closeStreamsSynchronously: true,
        ),
      );
      GetIt.I.registerSingleton<AppDatabase>(db);

      datasource = FavoriteDatasourceImpl(); // Initialize your datasource
    });

    tearDown(() async {
      GetIt.I.unregister<AppDatabase>();
      await db.close();
    });

    test('Can add and retrieve a favorite movie', () async {
      final movie = DriftMovieModel(
        id: null,
        isAdult: false,
        isCached: false,
        isFavorite: false,
        rating: 5.0,
        voteCount: 100,
        genres: 'Action,Adventure',
        backdropPath: '',
        originalLanguage: 'en',
        originalTitle: 'Test Movie',
        overview: 'Overview',
        posterPath: '',
        source: 'testSource',
        sourceId: 'testId',
      );
      await datasource.addFavoriteMovie(movie);

      final movies = await datasource.getFavoriteMovies();
      final record = movies.first;
      expect(movies.length, 1);
      expect(record.sourceId, 'tt0000001');
      expect(record.isAdult, false);
      expect(record.isCached, false);
      expect(record.isFavorite, false);
      expect(record.rating, 5.0);
      expect(record.voteCount, 100);
      expect(record.genres, 'Action,Adventure');
      expect(record.backdropPath, '');
      expect(record.originalLanguage, 'en');
      expect(record.originalTitle, 'Test Movie');
      expect(record.overview, 'Overview');
      expect(record.posterPath, '');
      expect(record.source, 'testSource');
      expect(record.sourceId, 'testId');

      final retrievedMovie = await datasource.getFavoriteMovieBySourceId(
        movie.sourceId,
        movie.source,
      );
      expect(retrievedMovie, isNotNull);
      expect(retrievedMovie!.originalTitle, movie.originalTitle);
    });
  });
}
