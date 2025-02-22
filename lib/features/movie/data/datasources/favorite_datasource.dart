import 'package:fpdart/fpdart.dart';
import 'package:movie_mite/core/database/drift_database.dart';
import 'package:movie_mite/core/resources/failures.dart';

abstract class FavoriteDatasource {
  /// Get a list of all favorite movies
  Future<Either<Failure, List<DriftMovieModel>>> getFavoriteMovies();

  /// Add movie to favorites
  Future<Either<Failure, void>> addFavoriteMovie(DriftMovieModel movie);

  /// Remove movie from favorites
  Future<Either<Failure, void>> removeFavoriteMovie(DriftMovieModel movie);
}

final class FavoriteDatasourceImpl implements FavoriteDatasource {
  @override
  Future<Either<Failure, List<DriftMovieModel>>> getFavoriteMovies() {
    // TODO: implement getFavoriteMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> addFavoriteMovie(DriftMovieModel movie) {
    // TODO: implement addFavoriteMovie
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> removeFavoriteMovie(DriftMovieModel movie) {
    // TODO: implement removeFavoriteMovie
    throw UnimplementedError();
  }
}
