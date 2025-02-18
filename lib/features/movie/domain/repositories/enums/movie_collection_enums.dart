/// Collection of movies
enum MovieCollection {
  favorite,
  nowShowing,
  popular,
  topRated,
  trending,
  upcoming,
}

extension MovieCollectionExt on MovieCollection {
  String get name => switch (this) {
    MovieCollection.favorite => 'Favorite',
    MovieCollection.nowShowing => 'Now Showing',
    MovieCollection.popular => 'Popular',
    MovieCollection.topRated => 'Top Rated',
    MovieCollection.trending => 'Trending',
    MovieCollection.upcoming => 'Upcoming',
  };
}
