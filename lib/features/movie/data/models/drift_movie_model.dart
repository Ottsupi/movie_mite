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
    required this.releaseDate,
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
    required this.title,
  });

  final int? id;
  final bool isAdult;
  final bool isCached;
  final bool isFavorite;
  final DateTime? releaseDate;
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
  final String title;

  MovieEntity toEntity() {
    return MovieEntity(
      isAdult: isAdult,
      isCached: isCached,
      isFavorite: isFavorite,
      releaseDate: releaseDate ?? null,
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
      title: title,
    );
  }

  factory DriftMovieModel.fromEntity(MovieEntity entity) {
    return DriftMovieModel(
      id: null,
      isAdult: entity.isAdult,
      isCached: entity.isCached,
      isFavorite: entity.isFavorite,
      releaseDate: entity.releaseDate,
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
      title: entity.title,
    );
  }

  factory DriftMovieModel.empty() {
    return DriftMovieModel.fromEntity(MovieEntity.empty());
  }

  DriftMovieTableCompanion toCompanion() {
    return DriftMovieTableCompanion(
      isAdult: Value(isAdult),
      isCached: Value(isCached),
      isFavorite: Value(isFavorite),
      releaseDate: Value(releaseDate ?? null),
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
      title: Value(title),
    );
  }

  factory DriftMovieModel.fromTableData(DriftMovieTableData data) {
    return DriftMovieModel(
      id: data.id,
      isAdult: data.isAdult,
      isCached: data.isCached,
      isFavorite: data.isFavorite,
      releaseDate: data.releaseDate,
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
      title: data.title,
    );
  }
}
