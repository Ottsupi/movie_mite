/// Collection of movies
enum MovieCollection {
  favorite,
  popular,
  nowShowing,
  topRated,
  trending,
  upcoming,
}

extension MovieCollectionExt on MovieCollection {
  String get name => switch (this) {
    MovieCollection.favorite => 'Favorites',
    MovieCollection.nowShowing => 'Now Showing',
    MovieCollection.popular => 'Popular',
    MovieCollection.topRated => 'Top Rated',
    MovieCollection.trending => 'Trending',
    MovieCollection.upcoming => 'Upcoming',
  };
}
