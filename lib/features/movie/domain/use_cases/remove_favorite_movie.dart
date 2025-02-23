import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/core/usecases/usecase.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/favorite_repository.dart';

class RemoveFavoriteMovie implements UseCase<void, RemoveFavoriteMovieParams> {
  final FavoriteRepository _favoriteRepository;

  RemoveFavoriteMovie(this._favoriteRepository);

  @override
  Future<Either<Failure, void>> call(params) {
    return _favoriteRepository.removeFavoriteMovie(params.movie);
  }
}

class RemoveFavoriteMovieParams extends Equatable {
  final MovieEntity movie;

  RemoveFavoriteMovieParams(this.movie);

  @override
  List<Object?> get props => [movie];
}
