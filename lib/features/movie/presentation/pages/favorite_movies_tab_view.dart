import 'package:flutter/material.dart';

class FavoriteMoviesTabView extends StatelessWidget {
  const FavoriteMoviesTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return FavoriteMovies();
  }
}

class FavoriteMovies extends StatelessWidget {
  const FavoriteMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Container(child: Center(child: Text('Favorites'))),
        ),
      ],
    );
  }
}
