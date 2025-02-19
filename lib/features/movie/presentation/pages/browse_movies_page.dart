import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/presentation/logic/logic.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list/movie_list_bloc.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list_status/movie_list_status_bloc.dart';
import 'package:movie_mite/features/movie/presentation/widgets/bottom_loading_builder.dart';
import 'package:movie_mite/features/movie/presentation/widgets/movie_list_builder.dart';
import 'package:rxdart/rxdart.dart';

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
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverAppBar(
          floating: true,
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          title: Text("Browse Movies"),
        ),
        MovieListBuilder(),
        BottomLoadingBuilder(),
      ],
    );
  }
}
