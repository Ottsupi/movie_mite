import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_mite/core/constants/tmdb_api_urls.dart';
import '../constants/keys.dart';

/// Add the required access token when making requests to themoviedb
final class TmbdAuthInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.startsWith(TmdbApiUrls.baseUrl))
      options.headers['Authorization'] = 'Bearer $TMDB_ACCESS_TOKEN';
    handler.next(options);
  }
}

void setupDio() {
  final dio = Dio();
  dio.interceptors.add(TmbdAuthInterceptor());
  GetIt.I.registerLazySingleton<Dio>(() => dio);
}
