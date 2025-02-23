// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tmdb_movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TmdbMovieModel _$TmdbMovieModelFromJson(Map<String, dynamic> json) =>
    TmdbMovieModel(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      genreIds:
          (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList(),
      id: (json['id'] as num?)?.toInt(),
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      popularity: _$JsonConverterFromJson<double, Decimal>(
        json['popularity'],
        const DecimalJsonConverter().fromJson,
      ),
      posterPath: json['poster_path'] as String?,
      releaseDate: const EmptyStringDateTimeConverter().fromJson(
        json['release_date'] as String?,
      ),
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: _$JsonConverterFromJson<double, Decimal>(
        json['vote_average'],
        const DecimalJsonConverter().fromJson,
      ),
      voteCount: (json['vote_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TmdbMovieModelToJson(TmdbMovieModel instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': _$JsonConverterToJson<double, Decimal>(
        instance.popularity,
        const DecimalJsonConverter().toJson,
      ),
      'poster_path': instance.posterPath,
      'release_date': const EmptyStringDateTimeConverter().toJson(
        instance.releaseDate,
      ),
      'title': instance.title,
      'video': instance.video,
      'vote_average': _$JsonConverterToJson<double, Decimal>(
        instance.voteAverage,
        const DecimalJsonConverter().toJson,
      ),
      'vote_count': instance.voteCount,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
