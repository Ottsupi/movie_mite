part of 'browse_movies_bloc.dart';

sealed class BrowseMoviesEvent extends Equatable {
  const BrowseMoviesEvent();

  @override
  List<Object> get props => [];
}

final class FetchPopularMovies extends BrowseMoviesEvent {}

final class FetchMoviesByCollection extends BrowseMoviesEvent {
  final int page;
  final MovieCollection collection;

  const FetchMoviesByCollection({required this.page, required this.collection});

  @override
  List<Object> get props => [page, collection];
}

final class FetchNextPage extends BrowseMoviesEvent {}

final class RefreshMovies extends BrowseMoviesEvent {}
