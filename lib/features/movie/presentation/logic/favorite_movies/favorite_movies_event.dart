part of 'favorite_movies_bloc.dart';

sealed class FavoriteMoviesEvent extends Equatable {
  const FavoriteMoviesEvent();

  @override
  List<Object> get props => [];
}

final class FetchFavoriteMovies extends FavoriteMoviesEvent {}

final class AddFavoriteMovieEvent extends FavoriteMoviesEvent {
  final MovieEntity movie;

  const AddFavoriteMovieEvent(this.movie);

  @override
  List<Object> get props => [movie];
}
