import 'package:fpdart/fpdart.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_list_status.dart';

/// Fetches [MovieEntity] from different places.
///
/// Although `get___Movies()` methods return a list of movies,
/// blocs interested in that list must subscribe to `movieListStream()`
abstract class MovieRepository {
  /// Get a list of movies sorted by popularity
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(int page);

  /// Get a list of movies from a collection
  Future<Either<Failure, List<MovieEntity>>> getMoviesByCollection(
    MovieCollection collection,
    int page,
  );

  /// Get a list of movies with a title that matches the string
  Future<Either<Failure, List<MovieEntity>>> searchMovieByTitle(
    String title,
    int page,
  );

  /// Stream of [MovieListStatus]
  Stream<MovieListStatus> movieListStatus();

  /// Stream of a list of [MovieEntity]
  Stream<List<MovieEntity>> movieListStream();

  /// Dispose of streams
  Future<void> dispose();
}
