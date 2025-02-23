import 'package:equatable/equatable.dart';
import 'package:fpdart/src/either.dart';
import 'package:movie_mite/core/resources/failures.dart';
import 'package:movie_mite/core/usecases/usecase.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';

class SearchMovieByTitle
    implements UseCase<List<MovieEntity>, SearchMovieByTitleParams> {
  final MovieRepository _movieRepository;

  SearchMovieByTitle(this._movieRepository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(
    SearchMovieByTitleParams params,
  ) async {
    return await _movieRepository.searchMovieByTitle(params.title, params.page);
  }
}

class SearchMovieByTitleParams extends Equatable {
  final String title;
  final int page;

  const SearchMovieByTitleParams({required this.title, required this.page});

  @override
  List<Object?> get props => [title, page];
}
