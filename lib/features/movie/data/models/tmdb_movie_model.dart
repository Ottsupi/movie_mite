import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_mite/core/utils/json_serializable/decimal.dart';
import 'package:movie_mite/core/utils/json_serializable/empty_string_datetime.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';

part 'tmdb_movie_model.g.dart';

@JsonSerializable()
final class TmdbMovieModel extends Equatable {
  TmdbMovieModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  final int? id;
  @JsonKey(name: 'original_language')
  final String? originalLanguage;
  @JsonKey(name: 'original_title')
  final String? originalTitle;
  final String? overview;
  @DecimalJsonConverter()
  final Decimal? popularity;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'release_date')
  @EmptyStringDateTimeConverter()
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  @DecimalJsonConverter()
  @JsonKey(name: 'vote_average')
  final Decimal? voteAverage;
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genreIds,
    id,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
  ];

  factory TmdbMovieModel.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$TmdbMovieModelToJson(this);

  MovieEntity toEntity() {
    return MovieEntity(
      isAdult: this.adult ?? false,
      isCached: false,
      isFavorite: false,
      rating: voteAverage ?? Decimal.zero,
      voteCount: voteCount ?? 0,
      genres: [],
      backdropPath: this.backdropPath ?? '',
      originalLanguage: this.originalLanguage ?? '',
      originalTitle: this.originalTitle ?? '',
      overview: this.overview ?? '',
      posterPath: this.posterPath ?? '',
      source: 'tmdb',
      sourceId: '$id',
    );
  }

  factory TmdbMovieModel.empty() => TmdbMovieModel(
    adult: false,
    backdropPath: '',
    genreIds: [],
    id: 0,
    originalLanguage: 'en',
    originalTitle: 'Movie Title',
    overview: 'A brief overview of the movie.',
    popularity: Decimal.zero,
    posterPath: '',
    releaseDate: DateTime.now(),
    title: 'Movie Title',
    video: false,
    voteAverage: Decimal.zero,
    voteCount: 0,
  );
}
