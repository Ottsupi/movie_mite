import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/presentation/logic/logic.dart';

class BrowseMoviesPage extends StatelessWidget {
  const BrowseMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<MovieRepository>(
      create: (context) => MovieRepositoryImpl(TmdbDatasource()),
      child: BlocProvider(
        create:
            (context) => BrowseMoviesBloc(
              RepositoryProvider.of<MovieRepository>(context),
            )..add(FetchPopularMovies()),
        child: BrowseMoviesScreen(),
      ),
    );
  }
}

class BrowseMoviesScreen extends StatelessWidget {
  const BrowseMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        title: Text("Browse Movies"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Durations.long1);
        },
        child: MovieListBuilder(),
      ),
    );
  }
}

class MovieListBuilder extends StatelessWidget {
  const MovieListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowseMoviesBloc, BrowseMoviesState>(
      builder: (context, state) {
        switch (state) {
          case BrowseMoviesInitial():
          case BrowseMoviesLoading():
            return const Center(child: CircularProgressIndicator());
          case BrowseMoviesFailed():
            return const Center(child: Text("Something went wrong!"));
          case BrowseMoviesEmpty():
            return const Center(child: Text("No movies found!"));
          case BrowseMoviesLoaded():
            return MovieList(movies: state.movies);
        }
      },
    );
  }
}

class MovieList extends StatelessWidget {
  const MovieList({super.key, required this.movies});

  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Text(movie.originalTitle);
  }
}
