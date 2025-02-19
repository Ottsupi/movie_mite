import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/core/usecases/usecase.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

class GetMoviesByCollection
    implements UseCase<List<MovieEntity>, GetMoviesByCollectionParams> {
  final MovieRepository _repository;

  GetMoviesByCollection(this._repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
    GetMoviesByCollectionParams params,
  ) async {
    return await _repository.getMoviesByCollection(
      params.collection,
      params.page,
    );
  }
}

class GetMoviesByCollectionParams extends Equatable {
  final int page;
  final MovieCollection collection;

  GetMoviesByCollectionParams({required this.page, required this.collection});

  @override
  List<Object?> get props => [page, collection];
}
