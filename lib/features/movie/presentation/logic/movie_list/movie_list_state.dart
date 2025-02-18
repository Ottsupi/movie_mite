part of 'movie_list_bloc.dart';

sealed class MovieListState extends Equatable {
  const MovieListState();
  
  @override
  List<Object> get props => [];
}

final class MovieListInitial extends MovieListState {}
