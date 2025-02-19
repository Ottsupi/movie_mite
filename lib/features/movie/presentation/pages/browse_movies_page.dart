import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/presentation/logic/logic.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list/movie_list_bloc.dart';

class BrowseMoviesPage extends StatelessWidget {
  const BrowseMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MovieRemoteDatasource>(
          create: (context) => TmdbDatasource(),
        ),
        RepositoryProvider<MovieRepository>(
          create:
              (context) => MovieRepositoryImpl(
                RepositoryProvider.of<MovieRemoteDatasource>(context),
              ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => MovieListBloc(
                  RepositoryProvider.of<MovieRepository>(context),
                ),
          ),
          BlocProvider(
            lazy: false,
            create:
                (context) => BrowseMoviesBloc(
                  RepositoryProvider.of<MovieRepository>(context),
                )..add(FetchMoviesByCollection(MovieCollection.popular)),
          ),
        ],
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
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Durations.long1);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
              title: Text("Browse Movies"),
            ),
            // Category(),
            MovieListBuilder(),
          ],
        ),
      ),
    );
  }
}

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

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
    ];
    return SliverToBoxAdapter(
      child: Column(
        children: [
          for (var color in colors) Container(height: 200, color: color),
        ],
      ),
    );
  }
}
