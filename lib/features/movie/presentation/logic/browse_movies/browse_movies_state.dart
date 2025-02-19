part of 'browse_movies_bloc.dart';

final class BrowseMoviesState extends Equatable {
  const BrowseMoviesState({
    required this.page,
    required this.collection,
    this.failure,
  });

  final int page;
  final MovieCollection collection;

  final Failure? failure;

  @override
  List<Object?> get props => [page, collection, failure];

  factory BrowseMoviesState.initial() {
    return BrowseMoviesState(page: 1, collection: MovieCollection.popular);
  }

  BrowseMoviesState copyWith({
    int? page,
    MovieCollection? collection,
    Failure? failure,
  }) {
    return BrowseMoviesState(
      page: page ?? this.page,
      collection: collection ?? this.collection,
      failure: failure ?? this.failure,
    );
  }
}
