import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/presentation/logic/logic.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list/movie_list_bloc.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list_status/movie_list_status_bloc.dart';
import 'package:movie_mite/features/movie/presentation/widgets/movie_list_builder.dart';
import 'package:movie_mite/features/movie/presentation/widgets/movie_list_status_builder.dart';

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
                    collection: MovieCollection.popular,
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
          BlocProvider.of<BrowseMoviesBloc>(context).add(RefreshMovies());
          return Future.delayed(Durations.long1);
        },
        child: BrowseMoviesScreenScrollView(),
      ),
    );
  }
}

class BrowseMoviesScreenScrollView extends StatefulWidget {
  const BrowseMoviesScreenScrollView({super.key});

  @override
  State<BrowseMoviesScreenScrollView> createState() =>
      _BrowseMoviesScreenScrollViewState();
}

class _BrowseMoviesScreenScrollViewState
    extends State<BrowseMoviesScreenScrollView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isBottom) context.read<BrowseMoviesBloc>().add(FetchNextPage());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          floating: true,
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          title: Text("Browse Movies"),
        ),
        MovieListStatusBuilder(),
        MovieListBuilder(),
      ],
    );
  }
}
