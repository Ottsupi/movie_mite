part of 'search_movies_bloc.dart';

sealed class SearchMoviesState extends Equatable {
  const SearchMoviesState();
  
  @override
  List<Object> get props => [];
}

final class SearchMoviesInitial extends SearchMoviesState {}
