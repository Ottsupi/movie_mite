import 'package:fpdart/src/either.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

final class MovieRepositoryImpl implements MovieRepository {
  final TmdbDatasource _tmdbDatasource = TmdbDatasource();

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies() async {
    try {
      final models = await _tmdbDatasource.getPopularMovies();
      final entities = models.map((e) => e.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(detail: e.detail));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getNextPage() {
    // TODO: implement getNextPage
    throw UnimplementedError();
  }

  @override
  Stream<MovieEntity> movieListStream() {
    // TODO: implement movieListStream
    throw UnimplementedError();
  }

  @override
  Stream<MovieListStatus> movieListStatus() {
    // TODO: implement movieListStatus
    throw UnimplementedError();
  }
}
