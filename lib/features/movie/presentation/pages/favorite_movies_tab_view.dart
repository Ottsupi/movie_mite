import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/features/movie/data/datasources/favorite_datasource.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/presentation/logic/browse_movies/browse_movies_bloc.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list/movie_list_bloc.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list_status/movie_list_status_bloc.dart';
import 'package:movie_mite/features/movie/presentation/widgets/movie_list_builder.dart';

class FavoriteMoviesTabView extends StatefulWidget {
  const FavoriteMoviesTabView({super.key});

  @override
  State<FavoriteMoviesTabView> createState() => _FavoriteMoviesTabViewState();
}

class _FavoriteMoviesTabViewState extends State<FavoriteMoviesTabView> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<MovieRepository>(
      create:
          (context) => MovieRepositoryImpl(
            RepositoryProvider.of<MovieRemoteDatasource>(context),
            RepositoryProvider.of<FavoriteDatasource>(context),
          ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MovieListBloc>(
            create:
                (context) => MovieListBloc(
                  RepositoryProvider.of<MovieRepository>(context),
                ),
          ),
          BlocProvider<BrowseMoviesBloc>(
            lazy: false,
            create:
                (context) => BrowseMoviesBloc(
                  RepositoryProvider.of<MovieRepository>(context),
                )..add(
                  FetchMoviesByCollection(
                    page: 1,
                    collection: MovieCollection.favorite,
                  ),
                ),
          ),
          BlocProvider<MovieListStatusBloc>(
            create:
                (context) => MovieListStatusBloc(
                  RepositoryProvider.of<MovieRepository>(context),
                ),
          ),
        ],
        child: FavoriteMovies(),
      ),
    );
  }
}

class FavoriteMovies extends StatelessWidget {
  const FavoriteMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<BrowseMoviesBloc>(context).add(
          FetchMoviesByCollection(
            page: 1,
            collection: MovieCollection.favorite,
          ),
        );
        return Future.delayed(Durations.extralong4);
      },
      child: CustomScrollView(slivers: [MovieListBuilder()]),
    );
  }
}
