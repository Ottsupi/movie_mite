import 'package:fpdart/fpdart.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';

abstract class FavoriteRepository {
  /// Get a list of all favorite movies
  Future<Either<Failure, List<MovieEntity>>> getFavoriteMovies();

  /// Add movie to favorite
  Future<Either<Failure, void>> addFavoriteMovie(MovieEntity movie);

  /// Add movie to favorite
  Future<Either<Failure, void>> removeFavoriteMovie(MovieEntity movie);

  /// Stream of a list of [MovieEntity]
  Stream<List<MovieEntity>> movieListStream();

  /// Dispose of streams
  Future<void> dispose();
}
