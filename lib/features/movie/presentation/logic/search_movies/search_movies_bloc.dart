import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_movies_event.dart';
part 'search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  SearchMoviesBloc() : super(SearchMoviesInitial()) {
    on<SearchMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
