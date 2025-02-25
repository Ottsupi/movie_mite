part of 'browse_movies_bloc.dart';

enum BrowseMoviesStatus { initial, loading, loaded, empty, failed }

extension BrowseMoviesStatusIsX on BrowseMoviesStatus {
  bool get isInitial => this == BrowseMoviesStatus.initial;
  bool get isLoading => this == BrowseMoviesStatus.loading;
  bool get isLoaded => this == BrowseMoviesStatus.loaded;
  bool get isEmpty => this == BrowseMoviesStatus.empty;
  bool get isFailed => this == BrowseMoviesStatus.failed;
}

final class BrowseMoviesState extends Equatable {
  const BrowseMoviesState({
    required this.page,
    required this.collection,
    required this.status,
    this.failure,
  });

  final int page;
  final MovieCollection collection;
  final BrowseMoviesStatus status;

  final Failure? failure;

  @override
  List<Object?> get props => [page, collection, status, failure];

  factory BrowseMoviesState.initial() {
    return BrowseMoviesState(
      page: 1,
      collection: MovieCollection.popular,
      status: BrowseMoviesStatus.initial,
    );
  }

  BrowseMoviesState copyWith({
    int? page,
    MovieCollection? collection,
    BrowseMoviesStatus? status,
    Failure? failure,
  }) {
    return BrowseMoviesState(
      page: page ?? this.page,
      collection: collection ?? this.collection,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
