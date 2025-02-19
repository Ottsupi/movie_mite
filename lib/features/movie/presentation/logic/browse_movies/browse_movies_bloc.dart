import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/domain/use_cases/get_movies_by_collection.dart';
import 'package:movie_mite/features/movie/domain/use_cases/get_popular_movies.dart';

part 'browse_movies_event.dart';
part 'browse_movies_state.dart';

class BrowseMoviesBloc extends Bloc<BrowseMoviesEvent, BrowseMoviesState> {
  final MovieRepository _movieRepository;
  final Logger logger = GetIt.I<Logger>();

  BrowseMoviesBloc(this._movieRepository) : super(BrowseMoviesState.initial()) {
    on<FetchPopularMovies>(_onGetPopularMovies);
    on<FetchMoviesByCollection>(_onFetchMoviesByCollection);
    on<FetchNextPage>(_onFetchNextPage);
  }

  _onGetPopularMovies(
    FetchPopularMovies event,
    Emitter<BrowseMoviesState> emit,
  ) async {
    emit(BrowseMoviesState(page: 1, collection: MovieCollection.popular));
    await GetPopularMovies(
      _movieRepository,
    ).call(GetPopularMoviesParams(page: 1));
  }

  _onFetchMoviesByCollection(
    FetchMoviesByCollection event,
    Emitter<BrowseMoviesState> emit,
  ) async {
    logger.d('Fetching movies collection: ${event.collection}');
    final params = GetMoviesByCollectionParams(
      collection: event.collection,
      page: 1,
    );
    final result = await GetMoviesByCollection(_movieRepository).call(params);
    result.fold(
      (failure) {
        emit(state.copyWith(failure: failure));
      },
      (movies) {
        emit(
          state.copyWith(page: 1, collection: event.collection, failure: null),
        );
      },
    );
  }

  _onFetchNextPage(FetchNextPage event, Emitter<BrowseMoviesState> emit) async {
    emit(BrowseMoviesState(page: 1, collection: state.collection));
    final newPage = state.page + 1;
    final params = GetMoviesByCollectionParams(
      collection: state.collection,
      page: newPage,
    );
    final result = await GetMoviesByCollection(_movieRepository).call(params);
    result.fold(
      (failure) {
        emit(state.copyWith(failure: failure));
      },
      (movies) {
        emit(
          state.copyWith(
            page: newPage,
            collection: state.collection,
            failure: null,
          ),
        );
      },
    );
  }
}
