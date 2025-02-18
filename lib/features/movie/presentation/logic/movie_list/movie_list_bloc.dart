import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository _movieRepository;
  late StreamSubscription<List<MovieEntity>> _movieListStreamSubscription;

  MovieListBloc(this._movieRepository) : super(MovieListState.empty()) {
    on<RecievedMovieList>(_onRecievedMovieList);

    _movieListStreamSubscription = _movieRepository.movieListStream().listen(
      (movieList) => add(RecievedMovieList(movieList)),
    );
  }

  _onRecievedMovieList(RecievedMovieList event, Emitter<MovieListState> emit) {
    emit(state.copyWith(movies: state.movies + event.movieList));
  }

  @override
  Future<void> close() {
    _movieListStreamSubscription.cancel();
    return super.close();
  }
}
