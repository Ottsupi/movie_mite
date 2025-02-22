import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/favorite_repository.dart';
import 'package:movie_mite/features/movie/domain/use_cases/add_favorite_movie.dart';
import 'package:movie_mite/features/movie/domain/use_cases/get_favorite_movies.dart';

part 'favorite_movies_event.dart';
part 'favorite_movies_state.dart';

class FavoriteMoviesBloc
    extends Bloc<FavoriteMoviesEvent, FavoriteMoviesState> {
  final FavoriteRepository _favoriteRepository;
  final Logger _logger = GetIt.instance<Logger>();

  FavoriteMoviesBloc(this._favoriteRepository)
    : super(FavoriteMoviesInitial()) {
    on<FetchFavoriteMovies>(_onFetchFavoriteMovies);
    on<AddFavoriteMovieEvent>(_onAddFavoritMovie);
  }

  _onFetchFavoriteMovies(
    FetchFavoriteMovies event,
    Emitter<FavoriteMoviesState> emit,
  ) async {
    emit(FavoriteMoviesLoading());
    final result = await GetFavoriteMovies(_favoriteRepository).call(null);
    _logger.d('GetFavoriteMovies returned: ${result.runtimeType}');
    result.fold(
      (failure) {
        emit(FavoriteMoviesFailed(failure));
      },
      (movies) {
        _logger.d(movies.length);
        for (MovieEntity movie in movies) {
          print(movie.originalTitle);
        }
        emit(FavoriteMoviesLoaded());
      },
    );
  }

  _onAddFavoritMovie(
    AddFavoriteMovieEvent event,
    Emitter<FavoriteMoviesState> emit,
  ) async {
    _logger.d('Add to favorites: ${event.movie.originalTitle}');
    emit(FavoriteMoviesLoading());
    final params = AddFavoriteMovieParams(event.movie);
    final result = await AddFavoriteMovie(_favoriteRepository).call(params);
    _logger.d('AddFavoriteMovie returned: ${result.runtimeType}');
    result.fold(
      (failure) => emit(FavoriteMoviesFailed(failure)),
      (movie) => emit(FavoriteMoviesLoaded()),
    );
  }
}
