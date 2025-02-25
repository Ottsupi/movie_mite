import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/core/constants/tmdb_api_urls.dart';
import 'package:movie_mite/features/movie/data/datasources/favorite_datasource.dart';
import 'package:movie_mite/features/movie/data/repositories/favorite_repository_impl.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/domain/repositories/favorite_repository.dart';
import 'package:movie_mite/features/movie/presentation/logic/favorite_movies/favorite_movies_bloc.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
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
      child: BlocProvider(
        create:
            (context) => FavoriteMoviesBloc(
              RepositoryProvider.of<FavoriteRepository>(context),
            ),
        child: MovieDetailSreen(movie: movie),
      ),
    );
  }
}

class MovieDetailSreen extends StatelessWidget {
  const MovieDetailSreen({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Details')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: MovieBackdrop(movie: movie)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MovieDetailSummary(movie: movie),
            ),
          ),
        ],
      ),
    );
  }
}

class MovieBackdrop extends StatelessWidget {
  const MovieBackdrop({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: MovieBackdropBuilder(movie: movie),
      ),
    );
  }
}

class MovieBackdropBuilder extends StatelessWidget {
  const MovieBackdropBuilder({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    if (movie.backdropPath.isEmpty) {
      return Center(
        child: const Icon(Icons.image, color: Colors.grey, size: 48.0),
      );
    }
    return CachedNetworkImage(
      imageUrl: '${TmdbImageUrls.backdrop}${movie.backdropPath}',
      errorWidget: (context, url, error) {
        return Icon(
          Icons.image,
          color: Theme.of(context).colorScheme.error,
          size: 48.0,
        );
      },
    );
  }
}

class MovieDetailSummary extends StatelessWidget {
  const MovieDetailSummary({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          movie.originalTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        Text(movie.overview, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: 16),
        MovieRating(movie: movie),
        SizedBox(height: 4),
        FavoriteToggleBuilder(movie: movie),
      ],
    );
  }
}

class FavoriteToggleBuilder extends StatelessWidget {
  const FavoriteToggleBuilder({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteMoviesBloc, FavoriteMoviesState>(
      listener: (context, state) {
        switch (state) {
          case FavoriteMoviesInitial():
            break;
          case FavoriteMoviesSuccess():
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.detail),
                duration: Durations.extralong4,
              ),
            );
          case FavoriteMoviesFailed():
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.detail),
                duration: Durations.extralong4,
              ),
            );
        }
      },
      child: FavoriteToggle(movie),
    );
  }
}

class FavoriteToggle extends StatelessWidget {
  const FavoriteToggle(this.movie, {super.key});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    if (movie.isFavorite) {
      return Row(
        children: [
          IconButton(
            onPressed: () {
              BlocProvider.of<FavoriteMoviesBloc>(
                context,
              ).add(RemoveFavoriteMovieEvent(movie));
            },
            icon: Icon(Icons.favorite, size: 36),
          ),
          SizedBox(width: 8),
          Text(
            'Remove from Favorites',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      );
    } else {
      return Row(
        children: [
          IconButton(
            onPressed: () {
              BlocProvider.of<FavoriteMoviesBloc>(
                context,
              ).add(AddFavoriteMovieEvent(movie));
            },
            icon: Icon(Icons.favorite_border, size: 36),
          ),
          SizedBox(width: 8),
          Text(
            'Add to Favorites',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      );
    }
  }
}

class MovieRating extends StatelessWidget {
  const MovieRating({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 2),
        Padding(
          padding: const EdgeInsets.only(bottom: 2.0),
          child: Icon(Icons.star, size: 48, color: Colors.amber),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${movie.rating.round(scale: 1)}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text('/10', style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            Text('${movie.voteCount} votes'),
          ],
        ),
      ],
    );
  }
}
