import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/core/constants/tmdb_api_urls.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/features/movie/data/models/tmdb_movie_model.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';

abstract class MovieRemoteDatasource {
  Future<List<TmdbMovieModel>> getPopularMovies(int page);
  Future<List<TmdbMovieModel>> getMoviesByCollection(
    MovieCollection collection,
    int page,
  );
  Future<List<TmdbMovieModel>> searchMoviesByTitle(String title, int page);
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

  @override
  Future<List<TmdbMovieModel>> getMoviesByCollection(
    MovieCollection collection,
    int page,
  ) async {
    String collectionToUrl(MovieCollection collection) {
      switch (collection) {
        case MovieCollection.nowShowing:
          return TmdbApiUrls.nowPlayingMovies;
        case MovieCollection.popular:
          return TmdbApiUrls.popularMovies;
        case MovieCollection.trending:
          return TmdbApiUrls.trendingMovies;
        case MovieCollection.upcoming:
          return TmdbApiUrls.upcomingMovies;
        case MovieCollection.topRated:
          return TmdbApiUrls.topRatedMovies;
        case MovieCollection.favorite:
          throw ServerException(
            detail: "Favorite movies are stored in the cache",
          );
      }
    }

    try {
      final response = await dio.get(
        collectionToUrl(collection),
        queryParameters: {'page': page},
      );
      final results = response.data['results'] as List;
      return results.map((e) => TmdbMovieModel.fromJson(e)).toList();
    } on DioException catch (e) {
      logger.d(e.requestOptions.path);
      throw ServerException(
        error: e,
        detail: e.message ?? "Could not fetch ${collection.name} movies",
      );
    } catch (e, s) {
      logger.w(
        "TmdbDatasource.getMoviesByCollection($collection, $page)",
        error: e,
        stackTrace: s,
      );
      throw ServerException(
        detail:
            "Something went wrong while fetching ${collection.name} movies.",
      );
    }
  }

  @override
  Future<List<TmdbMovieModel>> searchMoviesByTitle(
    String title,
    int page,
  ) async {
    try {
      final response = await dio.get(
        TmdbApiUrls.searchMovieByTitle,
        queryParameters: {'query': title, 'page': page},
      );
      final results = response.data['results'] as List;
      return results.map((e) => TmdbMovieModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerException(
        error: e,
        detail: e.message ?? "Could not search for movies entitled \"$title\".",
      );
    } catch (e, s) {
      logger.w(
        "TmdbDatasource.searchMoviesByTitle($title, $page)",
        error: e,
        stackTrace: s,
      );
      throw ServerException(
        detail: "Something went wrong while searching movies.",
      );
    }
  }
}
