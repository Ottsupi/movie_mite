import 'dart:async';

import 'package:fpdart/src/either.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

final class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(this._tmdbDatasource);

  final TmdbDatasource _tmdbDatasource;
  final _movieListStatusController = StreamController<MovieListStatus>();
  final _movieListStreamController = StreamController<List<MovieEntity>>();

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
  Stream<MovieListStatus> movieListStatus() async* {
    yield MovieListStatus.initial;
    yield* _movieListStatusController.stream;
  }

  @override
  Stream<List<MovieEntity>> movieListStream() async* {
    yield* _movieListStreamController.stream;
  }
}
