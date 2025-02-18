/// Collection of movies
enum MovieCollection {
  popular,
  nowShowing,
  trending,
  upcoming,
  latest,
  topRated,
  favorite,
}

extension MovieCollectionExt on MovieCollection {
  String get name => switch (this) {
    MovieCollection.popular => 'Popular',
    MovieCollection.nowShowing => 'Now Showing',
    MovieCollection.trending => 'Trending',
    MovieCollection.upcoming => 'Upcoming',
    MovieCollection.latest => 'Latest',
    MovieCollection.topRated => 'Top Rated',
    MovieCollection.favorite => 'Favorite',
  };
}
