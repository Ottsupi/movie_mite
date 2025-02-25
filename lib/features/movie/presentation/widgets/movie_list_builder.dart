import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/core/constants/tmdb_api_urls.dart';
import 'package:movie_mite/features/movie/domain/entities/movie_entity.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list/movie_list_bloc.dart';
import 'package:movie_mite/features/movie/presentation/pages/movie_detail_page.dart';

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
    return SliverPadding(
      padding: EdgeInsets.all(8),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieCard(
            movies[index],
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movie: movies[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  const MovieCard(this.movie, {super.key, this.onTap, this.onDoubleTap});

  final MovieEntity movie;
  final void Function()? onTap;
  final void Function()? onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Container(
        color: Colors.black87,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Center(child: MovieCardImageBuilder(movie: movie)),
            Container(
              height: 100,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.originalTitle,
                style: const TextStyle(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieCardImageBuilder extends StatelessWidget {
  const MovieCardImageBuilder({super.key, required this.movie});

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    if (movie.posterPath.isEmpty) {
      return const Icon(Icons.image, color: Colors.grey, size: 48.0);
    }
    return CachedNetworkImage(
      imageUrl: '${TmdbImageUrls.poster}${movie.posterPath}',
      errorWidget: (context, url, error) {
        return Icon(
          Icons.image,
          color: Theme.of(context).colorScheme.error,
          size: 48.0,
        );
      },
      fit: BoxFit.cover,
    );
  }
}
