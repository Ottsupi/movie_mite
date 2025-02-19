import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_list_status.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final MovieRepository _movieRepository;
  late StreamSubscription<List<MovieEntity>> _movieListStreamSubscription;
  late StreamSubscription<MovieListStatus> _movieListStatusSubscription;

  final logger = GetIt.instance.get<Logger>();

  MovieListBloc(this._movieRepository) : super(MovieListState.empty()) {
    on<RecievedMovieList>(_onRecievedMovieList);
    on<ReceivedMovieListStatus>(_onReceivedMovieListStatus);

    _movieListStreamSubscription = _movieRepository.movieListStream().listen(
      (movieList) => add(RecievedMovieList(movieList)),
      onError: (error) => logger.e(error),
    );
    _movieListStatusSubscription = _movieRepository.movieListStatus().listen(
      (status) => add(ReceivedMovieListStatus(status)),
      onError: (error) => logger.e(error),
    );
  }

  _onRecievedMovieList(RecievedMovieList event, Emitter<MovieListState> emit) {
    emit(state.copyWith(movies: state.movies + event.movieList));
  }

  _onReceivedMovieListStatus(
    ReceivedMovieListStatus event,
    Emitter<MovieListState> emit,
  ) {
    if (event.status == MovieListStatus.initial) {
      emit(state.copyWith(movies: []));
    }
  }

  @override
  Future<void> close() {
    _movieListStreamSubscription.cancel();
    _movieListStatusSubscription.cancel();
    return super.close();
  }
}
