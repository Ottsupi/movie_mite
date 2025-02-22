import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/features/movie/data/datasources/favorite_datasource.dart';
import 'package:movie_mite/features/movie/data/datasources/tmdb_datasource.dart';
import 'package:movie_mite/features/movie/data/repositories/movie_repository_impl.dart';
import 'package:movie_mite/features/movie/domain/repositories/movie_repository.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list/movie_list_bloc.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list_status/movie_list_status_bloc.dart';
import 'package:movie_mite/features/movie/presentation/logic/search_movies/search_movies_bloc.dart';
import 'package:movie_mite/features/movie/presentation/widgets/movie_list_builder.dart';
import 'package:rxdart/rxdart.dart';

class SearchMoviesTabView extends StatefulWidget {
  const SearchMoviesTabView({super.key});

  @override
  State<SearchMoviesTabView> createState() => _SearchMoviesTabViewState();
}

class _SearchMoviesTabViewState extends State<SearchMoviesTabView> {
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
          BlocProvider<SearchMoviesBloc>(
            lazy: false,
            create:
                (context) => SearchMoviesBloc(
                  RepositoryProvider.of<MovieRepository>(context),
                ),
          ),
          BlocProvider<MovieListStatusBloc>(
            create:
                (context) => MovieListStatusBloc(
                  RepositoryProvider.of<MovieRepository>(context),
                ),
          ),
        ],
        child: SearchResults(),
      ),
    );
  }
}

class SearchResults extends StatefulWidget {
  const SearchResults({super.key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final _scrollController = ScrollController();
  final _scrollSubject = PublishSubject<void>();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      _scrollSubject.add(null);
    });

    _scrollSubject.debounceTime(const Duration(milliseconds: 500)).listen((_) {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels > 0) {
        context.read<SearchMoviesBloc>().add(FetchNextPage());
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
        return Future.delayed(Durations.extralong4);
      },
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [SearchBox(), MovieListBuilder()],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextFormField(
          decoration: InputDecoration(hintText: "Search for movie title..."),
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) {
            BlocProvider.of<SearchMoviesBloc>(
              context,
            ).add(FetchMovieByTitle(page: 1, title: value));
          },
        ),
      ),
    );
  }
}
