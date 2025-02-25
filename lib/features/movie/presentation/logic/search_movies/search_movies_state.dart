part of 'search_movies_bloc.dart';

enum SearchMoviesStatus { initial, loading, loaded, empty, lastPage, failed }

extension SearchMoviesStatusIsX on SearchMoviesStatus {
  bool get isInitial => this == SearchMoviesStatus.initial;
  bool get isLoading => this == SearchMoviesStatus.loading;
  bool get isLoaded => this == SearchMoviesStatus.loaded;
  bool get isEmpty => this == SearchMoviesStatus.empty;
  bool get isLastPage => this == SearchMoviesStatus.lastPage;
  bool get isFailed => this == SearchMoviesStatus.failed;
}

final class SearchMoviesState extends Equatable {
  SearchMoviesState({
    required this.page,
    required this.title,
    required this.status,
    this.failure,
  });

  final int page;
  final String title;
  final SearchMoviesStatus status;

  final Failure? failure;

  @override
  List<Object?> get props => [page, title, status, failure];

  factory SearchMoviesState.initial() {
    return SearchMoviesState(
      page: 0,
      status: SearchMoviesStatus.initial,
      title: '',
    );
  }

  SearchMoviesState copyWith({
    int? page,
    String? title,
    SearchMoviesStatus? status,
    Failure? failure,
  }) {
    return SearchMoviesState(
      page: page ?? this.page,
      title: title ?? this.title,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
