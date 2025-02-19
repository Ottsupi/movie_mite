import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/core/usecases/usecase.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

class GetPopularMovies
    implements UseCase<List<MovieEntity>, GetPopularMoviesParams> {
  final MovieRepository _repository;

  GetPopularMovies(this._repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
    GetPopularMoviesParams params,
  ) async {
    return await _repository.getPopularMovies(params.page);
  }
}

class GetPopularMoviesParams extends Equatable {
  final int page;

  GetPopularMoviesParams({required this.page});

  @override
  List<Object?> get props => [page];
}
