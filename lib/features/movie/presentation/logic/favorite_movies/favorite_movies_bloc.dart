import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/repositories/favorite_repository.dart';
import 'package:movie_mite/features/movie/domain/use_cases/get_favorite_movies.dart';

part 'favorite_movies_event.dart';
part 'favorite_movies_state.dart';

class FavoriteMoviesBloc
    extends Bloc<FavoriteMoviesEvent, FavoriteMoviesState> {
  final FavoriteRepository _favoriteRepository;

  FavoriteMoviesBloc(this._favoriteRepository)
    : super(FavoriteMoviesInitial()) {
    on<FetchFavoriteMovies>(_onFetchFavoriteMovies);
  }

  _onFetchFavoriteMovies(
    FetchFavoriteMovies event,
    Emitter<FavoriteMoviesState> emit,
  ) async {
    emit(FavoriteMoviesLoading());
    final result = await GetFavoriteMovies(_favoriteRepository).call(null);
    result.fold(
      (failure) => emit(FavoriteMoviesFailed(failure)),
      (movies) => emit(FavoriteMoviesLoaded()),
    );
  }
}
