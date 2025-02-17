import 'package:flutter_test/flutter_test.dart';
import 'package:movie_mite/features/movie/data/models/tmdb_movie_model.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';

void main() {
  group('TmdbMovieModel', () {
    late Map<String, dynamic> json;

    setUp(() {
      json = {
        "adult": false,
        "backdrop_path": "/zo8CIjJ2nfNOevqNajwMRO6Hwka.jpg",
        "genre_ids": [16, 12, 10751, 35],
        "id": 1241982,
        "original_language": "en",
        "original_title": "Moana 2",
        "overview":
            "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced.",
        "popularity": 3682.351,
        "poster_path": "/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg",
        "release_date": "2024-11-21",
        "title": "Moana 2",
        "video": false,
        "vote_average": 7.194,
        "vote_count": 1468,
      };
    });

    test('Should be able to deserialize sample json', () {
      expect(TmdbMovieModel.fromJson(json), isA<TmdbMovieModel>());
    });

    test('Should be able to convert to MovieEntity', () {
      expect(TmdbMovieModel.fromJson(json).toEntity(), isA<MovieEntity>());
    });
  });
}
