import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_list_status.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

part 'movie_list_status_event.dart';
part 'movie_list_status_state.dart';

class MovieListStatusBloc
    extends Bloc<MovieListStatusEvent, MovieListStatusState> {
  final MovieRepository _movieRepository;
  late StreamSubscription<MovieListStatus> _movieListStatusSubscription;

  final logger = GetIt.instance.get<Logger>();
  MovieListStatusBloc(this._movieRepository) : super(MovieListStatusInitial()) {
    on<ReceivedStatus>(_onReceivedStatus);

    _movieListStatusSubscription = _movieRepository.movieListStatus().listen(
      onError: (error) => logger.e(error),
      (movieStatus) {
        add(ReceivedStatus(movieStatus));
      },
    );
  }

  _onReceivedStatus(ReceivedStatus event, Emitter<MovieListStatusState> emit) {
    switch (event.movieStatus) {
      case MovieListStatus.initial:
        emit(MovieListStatusInitial());
      case MovieListStatus.loading:
        emit(MovieListStatusLoading());
      case MovieListStatus.networkLoaded:
        emit(MovieListStatusNetworkLoaded());
      case MovieListStatus.cacheLoaded:
        emit(MovieListStatusCacheLoaded());
      case MovieListStatus.error:
        emit(MovieListStatusError());
    }
  }

  @override
  Future<void> close() {
    _movieListStatusSubscription.cancel();
    return super.close();
  }
}
