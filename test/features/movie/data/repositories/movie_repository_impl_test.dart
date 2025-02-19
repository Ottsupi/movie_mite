import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_mite/core/resources/exceptions.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/data/models/tmdb_movie_model.dart';
import 'package:movie_mite/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_list_status.dart';

class MockRemoteDatasource extends Mock implements MovieRemoteDatasource {}

void main() {
  late MovieRepositoryImpl repository;
  late MockRemoteDatasource remoteDatasource;
  late List<TmdbMovieModel> models;

  setUp(() {
    remoteDatasource = MockRemoteDatasource();
    repository = MovieRepositoryImpl(remoteDatasource);
    models = [
      TmdbMovieModel.empty(),
      TmdbMovieModel.empty(),
      TmdbMovieModel.empty(),
      TmdbMovieModel.empty(),
      TmdbMovieModel.empty(),
    ];
  });

  tearDown(() => GetIt.I.reset());

  group('getPopularMovies()', () {
    setUp(() {
      when(
        () => remoteDatasource.getPopularMovies(any()),
      ).thenAnswer((_) async => models);
    });

    test('movieListStatus emits correct values in order', () async {
      await repository.getPopularMovies(1);
      expectLater(
        repository.movieListStatus(),
        emitsInOrder([
          MovieListStatus.initial,
          MovieListStatus.loading,
          MovieListStatus.networkLoaded,
        ]),
      );
    });

    test('movieListStatus emits correct values when page != 1', () async {
      await repository.getPopularMovies(2);
      expectLater(
        repository.movieListStatus(),
        emitsInOrder([MovieListStatus.loading, MovieListStatus.networkLoaded]),
      );
    });

    test('movieListStream emits a list of movies', () async {
      await repository.getPopularMovies(1);
      expectLater(
        repository.movieListStream(),
        emits(isA<List<MovieEntity>>()),
      );
    });

    test('returns a list of movie entities', () async {
      final result = await repository.getPopularMovies(1);
      expectLater(result, isA<Right<Failure, List<MovieEntity>>>());
    });

    test('returns Failure', () async {
      when(
        () => remoteDatasource.getPopularMovies(any()),
      ).thenThrow(ServerException(detail: 'Test Error Handling'));

      final result = await repository.getPopularMovies(1);
      expectLater(result, isA<Left<Failure, List<MovieEntity>>>());
    });
  });
}
