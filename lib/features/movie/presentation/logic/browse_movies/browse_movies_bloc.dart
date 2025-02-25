import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/domain/use_cases/get_movies_by_collection.dart';

part 'browse_movies_event.dart';
part 'browse_movies_state.dart';

class BrowseMoviesBloc extends Bloc<BrowseMoviesEvent, BrowseMoviesState> {
  final MovieRepository _movieRepository;
  final Logger logger = GetIt.I<Logger>();

  static const int maxPages = 10;
  static const int itemsPerPage = 20;

  BrowseMoviesBloc(this._movieRepository) : super(BrowseMoviesState.initial()) {
    on<FetchMoviesByCollection>(_onFetchMoviesByCollection);
    on<FetchNextPage>(_onFetchNextPage);
    on<RefreshMovies>(_onRefreshMovies);
  }

  _onFetchMoviesByCollection(
    FetchMoviesByCollection event,
    Emitter<BrowseMoviesState> emit,
  ) async {
    emit(state.copyWith(status: BrowseMoviesStatus.loading));
    final params = GetMoviesByCollectionParams(
      collection: event.collection,
      page: event.page,
    );
    final result = await GetMoviesByCollection(_movieRepository).call(params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            page: event.page - 1,
            status: BrowseMoviesStatus.failed,
            failure: failure,
          ),
        );
      },
      (movies) {
        BrowseMoviesState newState = state.copyWith(
          page: event.page,
          collection: event.collection,
          status: BrowseMoviesStatus.loaded,
          failure: null,
        );
        if (movies.isEmpty) {
          newState = newState.copyWith(status: BrowseMoviesStatus.empty);
        }
        emit(newState);
      },
    );
  }

  _onFetchNextPage(FetchNextPage event, Emitter<BrowseMoviesState> emit) async {
    if (state.page >= maxPages) return;
    add(
      FetchMoviesByCollection(
        page: state.page + 1,
        collection: state.collection,
      ),
    );
  }

  _onRefreshMovies(RefreshMovies event, Emitter<BrowseMoviesState> emit) async {
    add(FetchMoviesByCollection(page: 1, collection: state.collection));
  }
}
