part of 'favorite_movies_bloc.dart';

sealed class FavoriteMoviesState extends Equatable {
  const FavoriteMoviesState();

  @override
  List<Object> get props => [];
}

final class FavoriteMoviesInitial extends FavoriteMoviesState {}

final class FavoriteMoviesSuccess extends FavoriteMoviesState {
  final String detail;

  const FavoriteMoviesSuccess(this.detail);

  @override
  List<Object> get props => [detail];
}

final class FavoriteMoviesFailed extends FavoriteMoviesState {
  final Failure failure;

  const FavoriteMoviesFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
