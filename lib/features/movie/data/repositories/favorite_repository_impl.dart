import 'dart:async';

import 'package:fpdart/src/either.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/data/datasources/favorite_datasource.dart';
import 'package:movie_mite/features/movie/data/models/drift_movie_model.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_list_status.dart';
import 'package:movie_mite/features/movie/domain/repositories/favorite_repository.dart';

final class FavoriteRepositoryImpl implements FavoriteRepository {
  FavoriteRepositoryImpl(this._favoriteDatasource);

  final FavoriteDatasource _favoriteDatasource;
  final _logger = GetIt.I.get<Logger>();

  final _movieListStatusController =
      StreamController<MovieListStatus>.broadcast();
  final _movieListStreamController =
      StreamController<List<MovieEntity>>.broadcast();

  @override
  Future<Either<Failure, List<MovieEntity>>> getFavoriteMovies() async {
    try {
      final result = await _favoriteDatasource.getFavoriteMovies();
      return Right(result.map((e) => e.toEntity()).toList());
    } on CacheFailure catch (e) {
      return Left(CacheFailure(detail: e.detail));
    }
  }

  @override
  Future<Either<Failure, void>> addFavoriteMovie(MovieEntity movie) async {
    DriftMovieModel? match;
    try {
      match = await _favoriteDatasource.getFavoriteMovieBySourceId(
        source: movie.source,
        sourceId: movie.sourceId,
      );
      if (match != null) {
        _logger.e("Movie is already in favorites");
        return Left(CacheFailure(detail: "Movie is already in favorites"));
      }
    } on CacheFailure catch (e) {
      return Left(CacheFailure(detail: e.detail));
    }

    try {
      final favorite = movie.copyWith(isFavorite: true);
      await _favoriteDatasource.addFavoriteMovie(
        DriftMovieModel.fromEntity(favorite),
      );
      return Right(null);
    } on CacheFailure catch (e) {
      return Left(CacheFailure(detail: e.detail));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavoriteMovie(MovieEntity movie) async {
    try {
      final result = await _favoriteDatasource.getFavoriteMovieBySourceId(
        source: movie.source,
        sourceId: movie.sourceId,
      );
      if (result is DriftMovieModel && result.id != null) {
        await _favoriteDatasource.removeFavoriteMovieById(result.id!);
      }
      return Right(null);
    } on CacheFailure catch (e) {
      return Left(CacheFailure(detail: e.detail));
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
}
