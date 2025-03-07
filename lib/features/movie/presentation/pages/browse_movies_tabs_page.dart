import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/core/presentation/widgets/banner_failure_widget.dart';
import 'package:movie_mite/features/movie/data/datasources/favorite_datasource.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/data/repositories/favorite_repository_impl.dart';
import 'package:movie_mite/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/favorite_repository.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/presentation/logic/browse_movies/browse_movies_bloc.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list/movie_list_bloc.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list_status/movie_list_status_bloc.dart';
import 'package:movie_mite/features/movie/presentation/pages/favorite_movies_tab_view.dart';
import 'package:movie_mite/features/movie/presentation/pages/search_movies_tab_view.dart';
import 'package:movie_mite/features/movie/presentation/widgets/movie_list_builder.dart';
import 'package:rxdart/rxdart.dart';

class BrowseMoviesTabsPage extends StatelessWidget {
  const BrowseMoviesTabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MovieRemoteDatasource>(
          create: (context) => TmdbDatasource(),
        ),
        RepositoryProvider<FavoriteDatasource>(
          create: (context) => FavoriteDatasourceImpl(),
        ),
        RepositoryProvider<FavoriteRepository>(
          create:
              (context) => FavoriteRepositoryImpl(
                RepositoryProvider.of<FavoriteDatasource>(context),
              ),
        ),
      ],
      child: BrowseMoviesTabsScreen(),
    );
  }
}

class BrowseMoviesTabsScreen extends StatelessWidget {
  const BrowseMoviesTabsScreen({super.key});

  static const includedCollections = [
    MovieCollection.popular,
    MovieCollection.nowShowing,
    MovieCollection.topRated,
    MovieCollection.trending,
    MovieCollection.upcoming,
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 2,
      length: 2 + includedCollections.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Movie Mite'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.favorite)),
              Tab(icon: Icon(Icons.search)),
              for (MovieCollection collection in includedCollections)
                Tab(text: collection.name),
            ],
          ),
        ),
        body: BrowseCollectionTabView(includedCollections),
      ),
    );
  }
}

class BrowseCollectionTabView extends StatelessWidget {
  const BrowseCollectionTabView(this.includedCollections, {super.key});

  final List<MovieCollection> includedCollections;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        FavoriteMoviesTabView(),
        SearchMoviesTabView(),
        for (MovieCollection collection in includedCollections)
          BrowseCollectionTab(collection: collection),
      ],
    );
  }
}

class BrowseCollectionTab extends StatefulWidget {
  const BrowseCollectionTab({super.key, required this.collection});

  final MovieCollection collection;

  @override
  State<BrowseCollectionTab> createState() => _BrowseCollectionTabState();
}

class _BrowseCollectionTabState extends State<BrowseCollectionTab> {
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
                    collection: widget.collection,
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
        child: BrowseCollection(collection: widget.collection),
      ),
    );
  }
}

class BrowseCollection extends StatefulWidget {
  const BrowseCollection({super.key, required this.collection});

  final MovieCollection collection;

  @override
  State<BrowseCollection> createState() => _BrowseCollectionState();
}

class _BrowseCollectionState extends State<BrowseCollection> {
  final _scrollController = ScrollController();
  final _scrollSubject = PublishSubject<void>();
  final logger = GetIt.I<Logger>();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      _scrollSubject.add(null);
    });

    _scrollSubject.debounceTime(const Duration(milliseconds: 500)).listen((_) {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels > 0) {
        logger.d('Fetch next page!');
        context.read<BrowseMoviesBloc>().add(FetchNextPage());
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(() {
      _scrollSubject.add(null);
    });
    _scrollController.dispose();
    _scrollSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        context.read<BrowseMoviesBloc>().add(
          FetchMoviesByCollection(page: 1, collection: widget.collection),
        );
        return Future.delayed(Durations.extralong4);
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          BrowseMovieListBuilder(),
          BrowseMoviesEndBuilder(widget.collection),
        ],
      ),
    );
  }
}

class BrowseMoviesEndBuilder extends StatelessWidget {
  const BrowseMoviesEndBuilder(this.collection, {super.key});

  final MovieCollection collection;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Center(
          child: BlocBuilder<BrowseMoviesBloc, BrowseMoviesState>(
            builder: (context, state) {
              final maxPages = BrowseMoviesBloc.maxPages;
              if (state.page == maxPages) {
                final maxResults = maxPages * BrowseMoviesBloc.itemsPerPage;
                return Column(
                  children: [
                    Text(
                      "Top ${maxResults} ${collection.name} Movies displayed",
                    ),
                    Text("Please choose another collection"),
                  ],
                );
              }
              if (state.status.isFailed) {
                return BannerFailureWidget(state.failure);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class BrowseMovieListBuilder extends StatelessWidget {
  const BrowseMovieListBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListBloc, MovieListState>(
      builder: (context, state) {
        return MoviesList(movies: state.movies, showFavoriteIndicator: true);
      },
    );
  }
}
