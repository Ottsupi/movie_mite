part of 'movie_list_bloc.dart';

final class MovieListState extends Equatable {
  const MovieListState({required this.movies});

  final List<MovieEntity> movies;

  factory MovieListState.empty() => const MovieListState(movies: []);

  @override
  List<Object> get props => [movies];

  MovieListState copyWith({List<MovieEntity>? movies}) {
    return MovieListState(movies: movies ?? this.movies);
  }
}
