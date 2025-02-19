import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/features/movie/domain/repositories/enums/movie_collection_enums.dart';
import 'package:movie_mite/features/movie/presentation/logic/browse_movies/browse_movies_bloc.dart';

class MovieCollectionsPicker extends StatelessWidget {
  const MovieCollectionsPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 32),
            for (final collection in MovieCollection.values)
              CollectionWidget(collection: collection),
            SizedBox(width: 32),
          ],
        ),
      ),
    );
  }
}

class CollectionWidget extends StatelessWidget {
  const CollectionWidget({super.key, required this.collection});

  final MovieCollection collection;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowseMoviesBloc, BrowseMoviesState>(
      buildWhen: (previous, current) {
        return previous.collection != current.collection;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: TextButton(
            onPressed: () {
              context.read<BrowseMoviesBloc>().add(
                FetchMoviesByCollection(page: 1, collection: collection),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor:
                  state.collection == collection
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              textStyle: const TextStyle(fontSize: 18),
            ),
            child: Text(collection.name),
          ),
        );
      },
    );
  }
}
