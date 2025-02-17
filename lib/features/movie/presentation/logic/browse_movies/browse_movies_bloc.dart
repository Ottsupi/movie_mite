import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'browse_movies_event.dart';
part 'browse_movies_state.dart';

class BrowseMoviesBloc extends Bloc<BrowseMoviesEvent, BrowseMoviesState> {
  BrowseMoviesBloc() : super(BrowseMoviesInitial()) {
    on<BrowseMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
