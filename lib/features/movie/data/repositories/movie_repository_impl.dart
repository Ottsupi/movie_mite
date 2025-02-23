import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/data/datasources/favorite_datasource.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_list_status.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

final class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(this._remoteMovieDatasource, this._favoriteDatasource);

  final MovieRemoteDatasource _remoteMovieDatasource;
  final FavoriteDatasource _favoriteDatasource;

  final _movieListStatusController =
      StreamController<MovieListStatus>.broadcast();
  final _movieListStreamController =
      StreamController<List<MovieEntity>>.broadcast();

  final logger = GetIt.instance.get<Logger>();

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
      if (collection == MovieCollection.favorite) {
        return await getFavoriteMovies();
      }
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
  Future<Either<Failure, List<MovieEntity>>> getFavoriteMovies() async {
    try {
      _movieListStatusController.add(MovieListStatus.initial);
      _movieListStatusController.add(MovieListStatus.loading);
      final result = await _favoriteDatasource.getFavoriteMovies();
      final entities = result.map((e) => e.toEntity()).toList();
      _movieListStreamController.add(entities);
      _movieListStatusController.add(MovieListStatus.cacheLoaded);
      return Right(entities);
    } on CacheFailure catch (e) {
      return Left(CacheFailure(detail: e.detail));
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
  Stream<MovieListStatus> movieListStatus() {
    return _movieListStatusController.stream;
  }

  @override
  Stream<List<MovieEntity>> movieListStream() {
    return _movieListStreamController.stream;
  }

  @override
  Future<void> dispose() async {
    await _movieListStatusController.close();
    await _movieListStreamController.close();
  }
}
