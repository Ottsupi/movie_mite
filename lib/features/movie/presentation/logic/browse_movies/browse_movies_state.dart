part of 'browse_movies_bloc.dart';

sealed class BrowseMoviesState extends Equatable {
  const BrowseMoviesState();
  
  @override
  List<Object> get props => [];
}

final class BrowseMoviesInitial extends BrowseMoviesState {}
