part of 'favorite_movies_bloc.dart';

sealed class FavoriteMoviesEvent extends Equatable {
  const FavoriteMoviesEvent();

  @override
  List<Object> get props => [];
}

final class FetchFavoriteMovies extends FavoriteMoviesEvent {
  const FetchFavoriteMovies();
}
