import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favorite_movies_event.dart';
part 'favorite_movies_state.dart';

class FavoriteMoviesBloc extends Bloc<FavoriteMoviesEvent, FavoriteMoviesState> {
  FavoriteMoviesBloc() : super(FavoriteMoviesInitial()) {
    on<FavoriteMoviesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
