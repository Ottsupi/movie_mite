part of 'browse_movies_bloc.dart';

sealed class BrowseMoviesEvent extends Equatable {
  const BrowseMoviesEvent();

  @override
  List<Object> get props => [];
}

final class FetchPopularMovies extends BrowseMoviesEvent {}

final class FetchMoviesByCollection extends BrowseMoviesEvent {
  final MovieCollection collection;

  const FetchMoviesByCollection(this.collection);

  @override
  List<Object> get props => [collection];
}

final class FetchNextPage extends BrowseMoviesEvent {}
