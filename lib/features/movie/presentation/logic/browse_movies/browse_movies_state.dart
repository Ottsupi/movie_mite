part of 'browse_movies_bloc.dart';

sealed class BrowseMoviesState extends Equatable {
  const BrowseMoviesState();

  @override
  List<Object> get props => [];
}

final class BrowseMoviesInitial extends BrowseMoviesState {}

final class BrowseMoviesLoading extends BrowseMoviesState {}

final class BrowseMoviesLoaded extends BrowseMoviesState {
  final List<MovieEntity> movies;

  const BrowseMoviesLoaded({required this.movies});
}

final class BrowseMoviesFailed extends BrowseMoviesState {}

final class BrowseMoviesEmpty extends BrowseMoviesState {}
