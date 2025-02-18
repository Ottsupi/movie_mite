import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/core/usecases/usecase.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

class GetPopularMovies implements UseCase<List<MovieEntity>, Params> {
  final MovieRepository _repository;

  GetPopularMovies(this._repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(Params params) async {
    return await _repository.getPopularMovies(params.page);
  }
}

class Params extends Equatable {
  final int page;

  Params({required this.page});

  @override
  List<Object?> get props => [page];
}
