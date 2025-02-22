import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/features/movie/presentation/logic/favorite_movies/favorite_movies_bloc.dart';

class FavoriteMoviesTabView extends StatefulWidget {
  const FavoriteMoviesTabView({super.key});

  @override
  State<FavoriteMoviesTabView> createState() => _FavoriteMoviesTabViewState();
}

class _FavoriteMoviesTabViewState extends State<FavoriteMoviesTabView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoriteMoviesBloc>(context).add(FetchFavoriteMovies());
  }

  @override
  Widget build(BuildContext context) {
    return FavoriteMovies();
  }
}

class FavoriteMovies extends StatelessWidget {
  const FavoriteMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<FavoriteMoviesBloc>().add(FetchFavoriteMovies());
      },
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Container(child: Center(child: Text('Favorites'))),
          ),
        ],
      ),
    );
  }
}
