import 'package:fpdart/fpdart.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';

/// The current status of the movie list stream.
///
/// * [initial] on startup or when the movie list is cleared
/// * [loading] a network request is ongoing or retrieving from cache
/// * [networkLoaded] data loaded from network
/// * [cacheLoaded] data loaded from cache
/// * [error] a problem occured
enum MovieListStatus { initial, loading, networkLoaded, cacheLoaded, error }

/// Fetches [MovieEntity] from different places.
///
/// Although `get___Movies()` methods return a list of movies,
/// blocs interested in that list must subscribe to `movieListStream()`
abstract class MovieRepository {
  /// Get a list of movies sorted by popularity
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(int page);

  /// Get a list of movies sorted by ratings
  Future<Either<Failure, List<MovieEntity>>> getTopRatedMovies(int page);

  /// Get a list of movies now showing in cinemas
  Future<Either<Failure, List<MovieEntity>>> getNowShowingMovies(int page);

  /// Get a list of movies with a title that matches the string
  Future<Either<Failure, List<MovieEntity>>> searchMovieByTitle(
    String title,
    int page,
  );

  /// Stream of [MovieListStatus]
  Stream<MovieListStatus> movieListStatus();

  /// Stream of a list of [MovieEntity]
  Stream<List<MovieEntity>> movieListStream();
}
