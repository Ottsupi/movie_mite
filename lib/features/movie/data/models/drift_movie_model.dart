import 'package:decimal/decimal.dart';
import 'package:drift/drift.dart';
import 'package:movie_mite/core/database/drift_database.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';

final class DriftMovieModel {
  DriftMovieModel({
    required this.id,
    required this.isAdult,
    required this.isCached,
    required this.isFavorite,
    required this.rating,
    required this.voteCount,
    required this.genres,
    required this.backdropPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.source,
    required this.sourceId,
  });

  final int? id;
  final bool isAdult;
  final bool isCached;
  final bool isFavorite;
  final double rating;
  final int voteCount;
  final String genres;
  final String backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String source;
  final String sourceId;

  MovieEntity toEntity() {
    return MovieEntity(
      isAdult: isAdult,
      isCached: isCached,
      isFavorite: isFavorite,
      rating: Decimal.parse(rating.toString()),
      voteCount: voteCount,
      genres: genres.split(','),
      backdropPath: backdropPath,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      source: source,
      sourceId: sourceId,
    );
  }

  factory DriftMovieModel.empty() {
    final entity = MovieEntity.empty();
    return DriftMovieModel(
      id: null,
      isAdult: entity.isAdult,
      isCached: entity.isCached,
      isFavorite: entity.isFavorite,
      rating: entity.rating.toDouble(),
      voteCount: entity.voteCount,
      genres: entity.genres.join(','),
      backdropPath: entity.backdropPath,
      originalLanguage: entity.originalLanguage,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      posterPath: entity.posterPath,
      source: entity.source,
      sourceId: entity.sourceId,
    );
  }

  DriftMovieTableCompanion toCompanion() {
    return DriftMovieTableCompanion(
      isAdult: Value(isAdult),
      isCached: Value(isCached),
      isFavorite: Value(isFavorite),
      rating: Value(rating),
      voteCount: Value(voteCount),
      genres: Value(genres),
      backdropPath: Value(backdropPath),
      originalLanguage: Value(originalLanguage),
      originalTitle: Value(originalTitle),
      overview: Value(overview),
      posterPath: Value(posterPath),
      source: Value(source),
      sourceId: Value(sourceId),
    );
  }

  factory DriftMovieModel.fromTableData(DriftMovieTableData data) {
    return DriftMovieModel(
      id: data.id,
      isAdult: data.isAdult,
      isCached: data.isCached,
      isFavorite: data.isFavorite,
      rating: data.rating.toDouble(),
      voteCount: data.voteCount,
      genres: data.genres,
      backdropPath: data.backdropPath,
      originalLanguage: data.originalLanguage,
      originalTitle: data.originalTitle,
      overview: data.overview,
      posterPath: data.posterPath,
      source: data.source,
      sourceId: data.sourceId,
    );
  }
}
