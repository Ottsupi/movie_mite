import 'package:fpdart/fpdart.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/core/usecases/usecase.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/favorite_repository.dart';

class GetFavoriteMovies implements UseCase<List<MovieEntity>, void> {
  final FavoriteRepository _repository;

  GetFavoriteMovies(this._repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(void params) async {
    return await _repository.getFavoriteMovies();
  }
}
