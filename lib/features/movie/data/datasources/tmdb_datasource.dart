import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/core/constants/tmdb_api_urls.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/features/movie/data/models/tmdb_movie_model.dart';

abstract class MovieRemoteDatasource {
  Future<List<TmdbMovieModel>> getPopularMovies(int page);
}

final class TmdbDatasource implements MovieRemoteDatasource {
  final Dio dio = GetIt.I.get<Dio>();
  final logger = GetIt.I.get<Logger>();

  Future<List<TmdbMovieModel>> getPopularMovies(int page) async {
    try {
      final response = await dio.get(
        TmdbApiUrls.popularMovies,
        queryParameters: {'page': page},
      );
      final results = response.data['results'] as List;
      return results.map((e) => TmdbMovieModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerException(
        error: e,
        detail: e.message ?? "Could not fetch popular movies",
      );
    } catch (e, s) {
      logger.w("TmdbDatasource.getPopularMovies", error: e, stackTrace: s);
      throw ServerException(
        detail: "Something went wrong while fetching popular movies.",
      );
    }
  }
}
