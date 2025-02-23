part of 'search_movies_bloc.dart';

final class SearchMoviesState extends Equatable {
  SearchMoviesState({required this.page, required this.title, this.failure});

  final int page;
  final String title;

  final Failure? failure;

  @override
  List<Object?> get props => [page, title, failure];

  factory SearchMoviesState.initial() {
    return SearchMoviesState(page: 0, title: '');
  }

  SearchMoviesState copyWith({int? page, String? title, Failure? failure}) {
    return SearchMoviesState(
      page: page ?? this.page,
      title: title ?? this.title,
      failure: failure ?? this.failure,
    );
  }
}
