part of 'movie_list_status_bloc.dart';

sealed class MovieListStatusState extends Equatable {
  const MovieListStatusState();

  @override
  List<Object> get props => [];
}

final class MovieListStatusInitial extends MovieListStatusState {}

final class MovieListStatusLoading extends MovieListStatusState {}

final class MovieListStatusNetworkLoaded extends MovieListStatusState {}

final class MovieListStatusCacheLoaded extends MovieListStatusState {}

final class MovieListStatusError extends MovieListStatusState {}
