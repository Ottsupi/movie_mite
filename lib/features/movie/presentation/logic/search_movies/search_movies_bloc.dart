import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/domain/use_cases/search_movie_by_title.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final MovieRepository _movieRepository;

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
    emit(SearchMoviesState(page: event.page, title: event.title));
    final params = SearchMovieByTitleParams(
      page: event.page,
      title: event.title,
    );
    final result = await SearchMovieByTitle(_movieRepository).call(params);
    result.fold(
      (failure) {
        emit(state.copyWith(page: event.page - 1, failure: failure));
      },
      (movies) {
        emit(
          state.copyWith(page: event.page, title: event.title, failure: null),
        );
      },
    );
  }

  _onFetchNextPage(FetchNextPage event, Emitter<SearchMoviesState> emit) {
    if (state.page >= maxPages) return;
    add(FetchMovieByTitle(page: state.page + 1, title: state.title));
  }

  _onRefresh(RefreshMovies event, Emitter<SearchMoviesState> emit) {
    add(FetchMovieByTitle(page: 1, title: state.title));
  }
}
