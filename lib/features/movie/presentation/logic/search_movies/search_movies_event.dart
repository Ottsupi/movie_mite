part of 'search_movies_bloc.dart';

sealed class SearchMoviesEvent extends Equatable {
  const SearchMoviesEvent();

  @override
  List<Object> get props => [];
}

final class FetchMovieByTitle extends SearchMoviesEvent {
  final int page;
  final String title;

  FetchMovieByTitle({required this.page, required this.title});

  @override
  List<Object> get props => [page, title];
}

final class FetchNextPage extends SearchMoviesEvent {}

final class RefreshMovies extends SearchMoviesEvent {}
