import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_list_status.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

final class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(this._remoteMovieDatasource);

  final MovieRemoteDatasource _remoteMovieDatasource;
  final _movieListStatusController = StreamController<MovieListStatus>();
  final _movieListStreamController = StreamController<List<MovieEntity>>();

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(int page) async {
    try {
      if (page == 1) _movieListStatusController.add(MovieListStatus.initial);
      _movieListStatusController.add(MovieListStatus.loading);
      final models = await _remoteMovieDatasource.getPopularMovies(page);
      final entities = models.map((e) => e.toEntity()).toList();
      _movieListStreamController.add(entities);
      _movieListStatusController.add(MovieListStatus.networkLoaded);
      return Right(entities);
    } on ServerException catch (e) {
      _movieListStatusController.add(MovieListStatus.error);
      return Left(ServerFailure(detail: e.detail));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getMoviesByCollection(
    MovieCollection collection,
    int page,
  ) async {
    try {
      if (page == 1) _movieListStatusController.add(MovieListStatus.initial);
      _movieListStatusController.add(MovieListStatus.loading);
      final models = await _remoteMovieDatasource.getMoviesByCollection(
        collection,
        page,
      );
      final entities = models.map((e) => e.toEntity()).toList();
      _movieListStreamController.add(entities);
      _movieListStatusController.add(MovieListStatus.networkLoaded);
      return Right(entities);
    } on ServerException catch (e) {
      _movieListStatusController.add(MovieListStatus.error);
      return Left(ServerFailure(detail: e.detail));
    }
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
    yield* _movieListStatusController.stream;
  }

  @override
  Stream<List<MovieEntity>> movieListStream() async* {
    yield* _movieListStreamController.stream;
  }

  @override
  Future<void> dispose() async {
    await _movieListStatusController.close();
    await _movieListStreamController.close();
  }
}
