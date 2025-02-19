part of 'movie_list_bloc.dart';

sealed class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

final class ReceivedMovieList extends MovieListEvent {
  const ReceivedMovieList(this.movieList);

  final List<MovieEntity> movieList;

  @override
  List<Object> get props => [movieList];
}

final class ReceivedMovieListStatus extends MovieListEvent {
  final MovieListStatus status;

  ReceivedMovieListStatus(this.status);

  @override
  List<Object> get props => [status];
}
