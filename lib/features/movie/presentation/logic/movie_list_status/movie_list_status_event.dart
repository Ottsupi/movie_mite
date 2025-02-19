part of 'movie_list_status_bloc.dart';

sealed class MovieListStatusEvent extends Equatable {
  const MovieListStatusEvent();

  @override
  List<Object> get props => [];
}

final class ReceivedStatus extends MovieListStatusEvent {
  final MovieListStatus movieStatus;

  const ReceivedStatus(this.movieStatus);

  @override
  List<Object> get props => [movieStatus];
}
