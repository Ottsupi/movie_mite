final class TmdbApiUrls {
  static const String baseUrl = "https://api.themoviedb.org";

  // Movies
  static const String nowPlayingMovies = "$baseUrl/3/movie/now_playing";
  static const String popularMovies = "$baseUrl/3/movie/popular";
  static const String topRatedMovies = "$baseUrl/3/movie/top_rated";
  static const String trendingMovies = "$baseUrl/3/trending/movie/day";
  static const String upcomingMovies = "$baseUrl/3/movie/upcoming";

  static const String searchMovieByTitle = "$baseUrl/3/search/movie";

  // Images
  static const String posterUrl = "https://image.tmdb.org/t/p/w342";
  static const String backdropUrl = "https://image.tmdb.org/t/p/w780";
}

final class TmdbImageUrls {
  static const String baseUrl = "https://image.tmdb.org";
  static const String poster = "$baseUrl/t/p/w342";
  static const String backdrop = "$baseUrl/t/p/w780";
}
