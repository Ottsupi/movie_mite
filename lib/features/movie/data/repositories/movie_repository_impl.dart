import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/data/datasources/favorite_datasource.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/data/models/tmdb_movie_model.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_list_status.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

final class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(this._remoteMovieDatasource, this._favoriteDatasource);

  final MovieRemoteDatasource _remoteMovieDatasource;
  final FavoriteDatasource _favoriteDatasource;
  final _logger = GetIt.instance.get<Logger>();

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
      return Left(ServerFailure.fromServerException(e));
    }
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getMoviesByCollection(
    MovieCollection collection,
    int page,
  ) async {
    if (collection == MovieCollection.favorite) return getFavoriteMovies();
    if (page == 1) _movieListStatusController.add(MovieListStatus.initial);

    // Start fetching the movies
    _movieListStatusController.add(MovieListStatus.loading);

    // Retrieve from remote
    List<TmdbMovieModel> models = [];
    try {
      models = await _remoteMovieDatasource.getMoviesByCollection(
        collection,
        page,
      );
    } on ServerException catch (e) {
      _movieListStatusController.add(MovieListStatus.error);
      return Left(ServerFailure.fromServerException(e));
    }

    // Convert to entities
    final entities = models.map((e) => e.toEntity()).toList();

    // Inject movies already in favorites
    final injection = await _injectFavorites(entities);
    final finalList = injection.fold((failure) => entities, (movies) => movies);

    // Return
    _movieListStreamController.add(finalList);
    _movieListStatusController.add(MovieListStatus.networkLoaded);
    return Right(finalList);
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
  ) async {
    try {
      if (page == 1) _movieListStatusController.add(MovieListStatus.initial);
      _movieListStatusController.add(MovieListStatus.loading);
      final result = await _remoteMovieDatasource.searchMoviesByTitle(
        title,
        page,
      );
      final entities = result.map((e) => e.toEntity()).toList();
      _movieListStreamController.add(entities);
      _movieListStatusController.add(MovieListStatus.networkLoaded);
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromServerException(e));
    }
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

  /// Injects favorite movies into a given list.
  Future<Either<Failure, List<MovieEntity>>> _injectFavorites(
    List<MovieEntity> movies,
  ) async {
    try {
      List<MovieEntity> injected = [];
      for (final movie in movies) {
        final match = await _favoriteDatasource.getFavoriteMovieBySourceId(
          source: movie.source,
          sourceId: movie.sourceId,
        );
        if (match != null) {
          injected.add(match.toEntity());
        } else {
          injected.add(movie);
        }
      }
      return Right(injected);
    } on CacheException catch (e) {
      _logger.e("Unable to inject favorite movies: $e");
      return Left(CacheFailure(detail: e.detail));
    }
  }
}
