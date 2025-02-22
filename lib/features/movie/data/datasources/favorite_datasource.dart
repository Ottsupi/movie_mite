import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_mite/core/database/drift_database.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/features/movie/data/models/drift_movie_model.dart';

abstract class FavoriteDatasource {
  /// Get a list of all favorite movies
  Future<List<DriftMovieModel>> getFavoriteMovies();

  /// Add movie to favorites
  Future<void> addFavoriteMovie(DriftMovieModel movie);

  /// Remove movie from favorites
  Future<void> removeFavoriteMovieById(int id);

  /// Get by source id
  Future<DriftMovieModel?> getFavoriteMovieBySourceId({
    required String sourceId,
    required String source,
  });
}

final class FavoriteDatasourceImpl implements FavoriteDatasource {
  final db = GetIt.I<AppDatabase>();

  @override
  Future<List<DriftMovieModel>> getFavoriteMovies() async {
    try {
      final results = await db.select(db.driftMovieTable).get();
      return results.map((e) => DriftMovieModel.fromTableData(e)).toList();
    } on Exception catch (e) {
      throw CacheException(detail: 'Could not get favorite movies', error: e);
    }
  }

  @override
  Future<void> addFavoriteMovie(DriftMovieModel movie) async {
    try {
      await db.into(db.driftMovieTable).insert(movie.toCompanion());
    } on Exception catch (e) {
      throw CacheException(detail: 'Could not add favorite movie', error: e);
    }
  }

  @override
  Future<void> removeFavoriteMovieById(int id) async {
    try {
      await db.delete(db.driftMovieTable)
        ..where((movie) => movie.id.equals(id));
    } on Exception catch (e) {
      throw CacheException(detail: 'Could not remove favorite movie', error: e);
    }
  }

  @override
  Future<DriftMovieModel?> getFavoriteMovieBySourceId({
    required String sourceId,
    required String source,
  }) async {
    try {
      final result =
          await (db.select(db.driftMovieTable)..where(
            (movie) =>
                movie.sourceId.equals(sourceId) & movie.source.equals(source),
          )).getSingleOrNull();
      if (result == null) return null;
      return DriftMovieModel.fromTableData(result);
    } on Exception catch (e) {
      throw CacheException(detail: 'Could not find favorite movie', error: e);
    }
  }
}
