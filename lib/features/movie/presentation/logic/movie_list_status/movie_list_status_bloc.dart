import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'movie_list_status_event.dart';
part 'movie_list_status_state.dart';

class MovieListStatusBloc extends Bloc<MovieListStatusEvent, MovieListStatusState> {
  MovieListStatusBloc() : super(MovieListStatusInitial()) {
    on<MovieListStatusEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
