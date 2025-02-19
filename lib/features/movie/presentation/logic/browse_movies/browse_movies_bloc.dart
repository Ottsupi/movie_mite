import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/domain/use_cases/get_popular_movies.dart';

part 'browse_movies_event.dart';
part 'browse_movies_state.dart';

class BrowseMoviesBloc extends Bloc<BrowseMoviesEvent, BrowseMoviesState> {
  final MovieRepository _movieRepository;

  BrowseMoviesBloc(this._movieRepository) : super(BrowseMoviesState.initial()) {
    on<FetchPopularMovies>(_onGetPopularMovies);
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
}
