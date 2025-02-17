import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_mite/core/constants/keys.dart';
import 'package:movie_mite/core/constants/tmdb_api_urls.dart';
import 'package:movie_mite/core/network/api_client.dart';

class MockRequestHandler extends Mock implements RequestInterceptorHandler {}

void main() {
  late MockRequestHandler handler;
  late Interceptor interceptor;

  setUp(() {
    handler = MockRequestHandler();
    interceptor = TmbdAuthInterceptor();
  });

  group('TmdbAuthInterceptor', () {
    test(
      'Tmdb authorization header should be present when requesting themoviedb.org api',
      () async {
        final options = RequestOptions(path: TmdbApiUrls.popularMovies);
        interceptor.onRequest(options, handler);

        expect(options.headers['Authorization'], 'Bearer $TMDB_ACCESS_TOKEN');
        verify(() => handler.next(options)).called(1);
      },
    );
    test(
      'Tmdb authorization header should NOT be present when requesting other addresses',
      () async {
        final options = RequestOptions(path: 'https://api.random.org');
        interceptor.onRequest(options, handler);

        expect(options.headers['Authorization'], isNull);
        verify(() => handler.next(options)).called(1);
      },
    );
  });
}
