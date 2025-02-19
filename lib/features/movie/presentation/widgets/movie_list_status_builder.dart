import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_mite/features/movie/presentation/logic/movie_list_status/movie_list_status_bloc.dart';

class MovieListStatusBuilder extends StatelessWidget {
  const MovieListStatusBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<MovieListStatusBloc, MovieListStatusState>(
        builder: (context, state) {
          switch (state) {
            case MovieListStatusInitial():
            case MovieListStatusLoading():
              return Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            case MovieListStatusNetworkLoaded():
              return SizedBox.shrink();
            case MovieListStatusCacheLoaded():
              return Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Data loaded from cache and may not be up to date.',
                    ),
                  ),
                ),
              );
            case MovieListStatusError():
              return Container(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('Something went wrong.'),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
