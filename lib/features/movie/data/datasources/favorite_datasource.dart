import 'package:movie_mite/core/database/drift_database.dart';

abstract class FavoriteDatasource {
  /// Get a list of all favorite movies
  Future<List<DriftMovieModel>> getFavoriteMovies();

  /// Add movie to favorites
  Future<void> addFavoriteMovie(DriftMovieModel movie);

  /// Remove movie from favorites
  Future<void> removeFavoriteMovie(DriftMovieModel movie);
}

final class FavoriteDatasourceImpl implements FavoriteDatasource {
  @override
  Future<List<DriftMovieModel>> getFavoriteMovies() async {
    // TODO: implement addFavoriteMovie
    throw UnimplementedError();
  }

  @override
  Future<void> addFavoriteMovie(DriftMovieModel movie) {
    // TODO: implement addFavoriteMovie
    throw UnimplementedError();
  }

  @override
  Future<void> removeFavoriteMovie(DriftMovieModel movie) {
    // TODO: implement removeFavoriteMovie
    throw UnimplementedError();
  }
}
