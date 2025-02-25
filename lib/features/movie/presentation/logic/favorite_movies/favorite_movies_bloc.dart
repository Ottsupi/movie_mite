import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/favorite_repository.dart';
import 'package:movie_mite/features/movie/domain/use_cases/add_favorite_movie.dart';
import 'package:movie_mite/features/movie/domain/use_cases/remove_favorite_movie.dart';

part 'favorite_movies_event.dart';
part 'favorite_movies_state.dart';

class FavoriteMoviesBloc
    extends Bloc<FavoriteMoviesEvent, FavoriteMoviesState> {
  final FavoriteRepository _favoriteRepository;
  final Logger _logger = GetIt.instance<Logger>();

  FavoriteMoviesBloc(this._favoriteRepository)
    : super(FavoriteMoviesInitial()) {
    on<AddFavoriteMovieEvent>(_onAddFavoriteMovie);
    on<RemoveFavoriteMovieEvent>(_onRemoveFavoriteMovie);
  }

  _onAddFavoriteMovie(
    AddFavoriteMovieEvent event,
    Emitter<FavoriteMoviesState> emit,
  ) async {
    final params = AddFavoriteMovieParams(event.movie);
    final result = await AddFavoriteMovie(_favoriteRepository).call(params);
    result.fold(
      (failure) {
        emit(FavoriteMoviesFailed(failure));
      },
      (movie) {
        emit(FavoriteMoviesSuccess("Added to favorites"));
      },
    );
  }

  _onRemoveFavoriteMovie(
    RemoveFavoriteMovieEvent event,
    Emitter<FavoriteMoviesState> emit,
  ) async {
    final params = RemoveFavoriteMovieParams(event.movie);
    final result = await RemoveFavoriteMovie(_favoriteRepository).call(params);
    result.fold(
      (failure) {
        emit(FavoriteMoviesFailed(failure));
      },
      (movie) {
        emit(FavoriteMoviesSuccess("Removed from favorites"));
      },
    );
  }
}
