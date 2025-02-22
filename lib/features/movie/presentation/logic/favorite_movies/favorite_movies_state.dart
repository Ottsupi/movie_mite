part of 'favorite_movies_bloc.dart';

sealed class FavoriteMoviesState extends Equatable {
  const FavoriteMoviesState();

  @override
  List<Object> get props => [];
}

final class FavoriteMoviesInitial extends FavoriteMoviesState {}

final class FavoriteMoviesLoading extends FavoriteMoviesState {}

final class FavoriteMoviesLoaded extends FavoriteMoviesState {}

final class FavoriteMoviesFailed extends FavoriteMoviesState {
  final Failure failure;

  const FavoriteMoviesFailed(this.failure);

  @override
  List<Object> get props => [failure];
}

final class FavoriteMoviesEmpty extends FavoriteMoviesState {}
