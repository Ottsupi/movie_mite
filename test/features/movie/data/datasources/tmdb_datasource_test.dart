import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_mite/core/constants/tmdb_api_urls.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/core/utils/logs/logger.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/data/models/tmdb_movie_model.dart';

class MockDio extends Mock implements Dio {}

void main() async {
  late MockDio dio;
  late Map<String, dynamic> jsonResponse;
  late TmdbDatasource datasource;

  setUp(() {
    setupLogger();
    dio = MockDio();
    GetIt.I.registerSingleton<Dio>(dio);
    datasource = TmdbDatasource();
    jsonResponse = {
      "page": 1,
      "results": [
        {
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
        },
        {
          "adult": false,
          "backdrop_path": "/zOpe0eHsq0A2NvNyBbtT6sj53qV.jpg",
          "genre_ids": [28, 878, 35, 10751],
          "id": 939243,
          "original_language": "en",
          "original_title": "Sonic the Hedgehog 3",
          "overview":
              "Sonic, Knuckles, and Tails reunite against a powerful new adversary, Shadow, a mysterious villain with powers unlike anything they have faced before. With their abilities outmatched in every way, Team Sonic must seek out an unlikely alliance in hopes of stopping Shadow and protecting the planet.",
          "popularity": 2997.868,
          "poster_path": "/d8Ryb8AunYAuycVKDp5HpdWPKgC.jpg",
          "release_date": "2024-12-19",
          "title": "Sonic the Hedgehog 3",
          "video": false,
          "vote_average": 7.77,
          "vote_count": 1747,
        },
      ],
      "total_pages": 48711,
      "total_results": 974212,
    };
  });

  tearDown(() {
    GetIt.I.reset();
  });

  group('TmdbDatasource', () {
    test(
      'getPopularMovies should return a list of TmdbMovieModel from provided sample json',
      () async {
        final response = Response(
          data: jsonResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: TmdbApiUrls.popularMovies),
        );

        when(
          () => dio.get(TmdbApiUrls.popularMovies),
        ).thenAnswer((_) async => response);

        final result = await datasource.getPopularMovies();
        expect(result, isA<List<TmdbMovieModel>>());
        expect(result.length, 2);
      },
    );

    test(
      'getPopularMovies should throw ServerException when Dio throws a DioException',
      () async {
        final dioException = DioException(
          requestOptions: RequestOptions(path: TmdbApiUrls.popularMovies),
          type: DioExceptionType.unknown,
        );

        when(() => dio.get(TmdbApiUrls.popularMovies)).thenThrow(dioException);

        expectLater(
          datasource.getPopularMovies(),
          throwsA(isA<ServerException>()),
        );
      },
    );
  });
}
