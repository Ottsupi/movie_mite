import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';

part 'browse_movies_event.dart';
part 'browse_movies_state.dart';

class BrowseMoviesBloc extends Bloc<BrowseMoviesEvent, BrowseMoviesState> {
  BrowseMoviesBloc() : super(BrowseMoviesInitial()) {
    on<GetPopularMovies>(_onGetPopularMovies);
  }

  _onGetPopularMovies(
    GetPopularMovies event,
    Emitter<BrowseMoviesState> emit,
  ) async {
    final sample = [
      MovieEntity.empty(),
      MovieEntity.empty(),
      MovieEntity.empty(),
      MovieEntity.empty(),
    ];
    emit(BrowseMoviesLoading());
    await Future.delayed(Durations.extralong4);
    emit(BrowseMoviesLoaded(movies: sample));
  }
}
