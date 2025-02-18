import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/domain/use_cases/get_popular_movies.dart';

part 'browse_movies_event.dart';
part 'browse_movies_state.dart';

class BrowseMoviesBloc extends Bloc<BrowseMoviesEvent, BrowseMoviesState> {
  final MovieRepository _movieRepository;

  BrowseMoviesBloc(this._movieRepository) : super(BrowseMoviesInitial()) {
    on<FetchPopularMovies>(_onGetPopularMovies);
  }

  _onGetPopularMovies(
    FetchPopularMovies event,
    Emitter<BrowseMoviesState> emit,
  ) async {
    emit(BrowseMoviesLoading());
    final result = await GetPopularMovies(
      _movieRepository,
    ).call(Params(page: 1));
    result.fold(
      (failure) => emit(BrowseMoviesFailed()),
      (movies) => emit(BrowseMoviesLoaded(movies: movies)),
    );
  }
}
