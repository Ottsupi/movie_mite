import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_mite/core/constants/tmdb_api_urls.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/features/movie/data/models/tmdb_movie_model.dart';

final class TmdbDatasource {
  final Dio dio = GetIt.I.get<Dio>();

  Future<List<TmdbMovieModel>> getPopularMovies() async {
    try {
      final response = await dio.get(TmdbApiUrls.popularMovies);
      final results = response.data['results'] as List;
      return results.map((e) => TmdbMovieModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerException(
        error: e,
        detail: e.message ?? "Could not fetch popular movies",
      );
    }
  }
}
