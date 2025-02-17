import 'package:fpdart/fpdart.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';

/// The current status of the movie list stream.
///
/// * [initial] on startup or when the movie list is cleared
/// * [fetching] a network request is ongoing or retrieving from cache
/// * [sending] there are movies in the queue to be sent to presentation layer
/// * [waiting] nothing is being processed at the moment
/// * [error] a problem occured
enum MovieListStatus { initial, fetching, sending, waiting, error }

abstract class MovieRepository {
  /// Get a list of popular movies
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies();

  /// Get the next page of the current endpoint
  Future<Either<Failure, List<MovieEntity>>> getNextPage();

  /// Stream of [MovieEntity]
  Stream<MovieEntity> movieListStream();

  /// Stream of [MovieListStatus]
  Stream<MovieListStatus> movieListStatus();
}
