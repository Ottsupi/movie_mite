part of 'movie_list_status_bloc.dart';

sealed class MovieListStatusEvent extends Equatable {
  const MovieListStatusEvent();

  @override
  List<Object> get props => [];
}

final class ReceivedStatusInitial extends MovieListStatusEvent {}

final class ReceivedStatusLoading extends MovieListStatusEvent {}

final class ReceivedStatusNetworkLoaded extends MovieListStatusEvent {}

final class ReceivedStatusCacheLoaded extends MovieListStatusEvent {}

final class ReceivedStatusError extends MovieListStatusEvent {}
