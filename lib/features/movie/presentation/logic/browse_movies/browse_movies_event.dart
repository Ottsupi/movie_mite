part of 'browse_movies_bloc.dart';

sealed class BrowseMoviesEvent extends Equatable {
  const BrowseMoviesEvent();

  @override
  List<Object> get props => [];
}

final class GetPopularMovies extends BrowseMoviesEvent {}
