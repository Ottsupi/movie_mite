import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list/movie_list_bloc.dart';

class MovieListBuilder extends StatelessWidget {
  const MovieListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      builder: (context, state) {
        return MoviesList(movies: state.movies);
      },
    );
  }
}

class MoviesList extends StatelessWidget {
  const MoviesList({super.key, required this.movies});

  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(movies[index].originalTitle),
          subtitle: Text(movies[index].overview),
        );
      },
    );
  }
}
