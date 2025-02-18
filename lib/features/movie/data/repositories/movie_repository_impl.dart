import 'package:fpdart/src/either.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

final class MovieRepositoryImpl implements MovieRepository {
  final TmdbDatasource _tmdbDatasource = TmdbDatasource();

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(int page) async {
    try {
      final models = await _tmdbDatasource.getPopularMovies();
      final entities = models.map((e) => e.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(detail: e.detail));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getNowShowingMovies(int page) {
    // TODO: implement getNowShowingMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getTopRatedMovies(int page) {
    // TODO: implement getTopRatedMovies
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> searchMovieByTitle(
    String title,
    int page,
  ) {
    // TODO: implement searchMovieByTitle
    throw UnimplementedError();
  }

  @override
  Stream<MovieListStatus> movieListStatus() {
    // TODO: implement movieListStatus
    throw UnimplementedError();
  }

  @override
  Stream<List<MovieEntity>> movieListStream() {
    // TODO: implement movieListStream
    throw UnimplementedError();
  }
}
