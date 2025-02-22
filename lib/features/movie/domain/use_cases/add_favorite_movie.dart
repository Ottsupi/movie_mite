import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/core/usecases/usecase.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/favorite_repository.dart';

class AddFavoriteMovie implements UseCase<void, AddFavoriteMovieParams> {
  final FavoriteRepository _favoriteRepository;

  AddFavoriteMovie(this._favoriteRepository);

  @override
  Future<Either<Failure, void>> call(params) {
    return _favoriteRepository.addFavoriteMovie(params.movie);
  }
}

class AddFavoriteMovieParams extends Equatable {
  final MovieEntity movie;

  AddFavoriteMovieParams(this.movie);

  @override
  List<Object?> get props => [movie];
}
