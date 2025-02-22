import 'package:fpdart/fpdart.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';

abstract class FavoriteDatasource {
  /// Get a list of all favorite movies
  Future<Either<Failure, List<MovieEntity>>> getFavoriteMovies();

  /// Add movie to favorites
  Future<Either<Failure, void>> addFavoriteMovie(MovieEntity movie);

  /// Remove movie from favorites
  Future<Either<Failure, void>> removeFavoriteMovie(MovieEntity movie);
}
