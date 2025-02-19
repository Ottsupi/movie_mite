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
    on<ReceivedStatusInitial>(_onReceivedStatusInitial);
    on<ReceivedStatusLoading>(_onReceivedStatusLoading);
    on<ReceivedStatusNetworkLoaded>(_onReceivedStatusNetworkLoaded);
    on<ReceivedStatusCacheLoaded>(_onReceivedStatusCacheLoaded);
    on<ReceivedStatusError>(_onReceivedStatusError);

    _movieListStatusSubscription = _movieRepository.movieListStatus().listen(
      onError: (error) => logger.e(error),
      (movieStatus) {
        switch (movieStatus) {
          case MovieListStatus.initial:
            add(ReceivedStatusInitial());
          case MovieListStatus.loading:
            add(ReceivedStatusLoading());
          case MovieListStatus.networkLoaded:
            add(ReceivedStatusNetworkLoaded());
          case MovieListStatus.cacheLoaded:
            add(ReceivedStatusCacheLoaded());
          case MovieListStatus.error:
            add(ReceivedStatusError());
        }
      },
    );
  }

  _onReceivedStatusInitial(
    ReceivedStatusInitial event,
    Emitter<MovieListStatusState> emit,
  ) {
    emit(MovieListStatusInitial());
  }

  _onReceivedStatusLoading(
    ReceivedStatusLoading event,
    Emitter<MovieListStatusState> emit,
  ) {
    emit(MovieListStatusLoading());
  }

  _onReceivedStatusNetworkLoaded(
    ReceivedStatusNetworkLoaded event,
    Emitter<MovieListStatusState> emit,
  ) {
    emit(MovieListStatusNetworkLoaded());
  }

  _onReceivedStatusCacheLoaded(
    ReceivedStatusCacheLoaded event,
    Emitter<MovieListStatusState> emit,
  ) {
    emit(MovieListStatusCacheLoaded());
  }

  _onReceivedStatusError(
    ReceivedStatusError event,
    Emitter<MovieListStatusState> emit,
  ) {
    emit(MovieListStatusError());
  }

  @override
  Future<void> close() {
    _movieListStatusSubscription.cancel();
    return super.close();
  }
}
