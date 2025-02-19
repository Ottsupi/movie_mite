import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/features/movie/presentation/logic/browse_movies/browse_movies_bloc.dart';

class BottomLoadingBuilder extends StatelessWidget {
  const BottomLoadingBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: BlocBuilder<BrowseMoviesBloc, BrowseMoviesState>(
          builder: (context, state) {
            final max = BrowseMoviesBloc.maxPages;
            final maxResults = max * BrowseMoviesBloc.itemsPerPage;
            if (state.page >= max) {
              return Column(
                children: [
                  Text(
                    "Top $maxResults ${state.collection.name} movies displayed.",
                  ),
                  Text(" Please try a different collection."),
                ],
              );
            }
            return Container(child: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
