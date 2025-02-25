import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/domain/use_cases/search_movie_by_title.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final MovieRepository _movieRepository;
  final _logger = GetIt.I.get<Logger>();

  static const int maxPages = 2;
  static const int itemsPerPage = 20;

  SearchMoviesBloc(this._movieRepository) : super(SearchMoviesState.initial()) {
    on<FetchMovieByTitle>(_onFetchMovieByTitle);
    on<FetchNextPage>(_onFetchNextPage);
    on<RefreshMovies>(_onRefresh);
  }

  _onFetchMovieByTitle(
    FetchMovieByTitle event,
    Emitter<SearchMoviesState> emit,
  ) async {
    emit(
      SearchMoviesState(
        page: event.page,
        status: SearchMoviesStatus.loading,
        title: event.title,
      ),
    );
    final params = SearchMovieByTitleParams(
      page: event.page,
      title: event.title,
    );
    final result = await SearchMovieByTitle(_movieRepository).call(params);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            page: event.page - 1,
            status: SearchMoviesStatus.failed,
            failure: failure,
          ),
        );
      },
      (movies) {
        SearchMoviesState newState = state.copyWith(
          page: event.page,
          title: event.title,
          status: SearchMoviesStatus.loaded,
          failure: null,
        );
        if (movies.isEmpty) {
          newState = newState.copyWith(status: SearchMoviesStatus.empty);
          // Edge case when search results is divisible by [itemsPerPage]
          if (event.page > 1) {
            _logger.d("Empty and last page...");
            newState = newState.copyWith(status: SearchMoviesStatus.lastPage);
          }
        } else if (movies.length < itemsPerPage) {
          newState = newState.copyWith(status: SearchMoviesStatus.lastPage);
        }
        emit(newState);
      },
    );
  }

  _onFetchNextPage(FetchNextPage event, Emitter<SearchMoviesState> emit) {
    if (state.page >= maxPages) return;
    if (state.status.isLastPage) return;
    add(FetchMovieByTitle(page: state.page + 1, title: state.title));
  }

  _onRefresh(RefreshMovies event, Emitter<SearchMoviesState> emit) {
    add(FetchMovieByTitle(page: 1, title: state.title));
  }
}
