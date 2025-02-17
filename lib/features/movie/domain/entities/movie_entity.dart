import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

/// A brief overview of a movie shown in lists
final class MovieEntity extends Equatable {
  /// Constant constructor
  const MovieEntity({
    required this.isAdult,
    required this.isCached,
    required this.isFavorite,
    required this.rating,
    required this.voteCount,
    required this.genres,
    required this.backdropPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.source,
    required this.sourceId,
  });

  /// Adult rating
  final bool isAdult;

  /// If the movie an be found in cache
  final bool isCached;

  /// If the movie an be found in cache
  final bool isFavorite;

  /// Numerical score given by critics
  /// indicating the overall quality of the show
  final Decimal rating;

  /// The number of votes recieved by the movie
  final int voteCount;

  /// List of genres applicable to the movie
  final List<String> genres;

  /// Path to the backdrop image
  final String backdropPath;

  /// Original language of the movie
  final String originalLanguage;

  /// Original title of the movie
  final String originalTitle;

  /// Brief summary of the movie
  final String overview;

  /// Path to the poster image
  final String posterPath;

  /// Movie repository source
  final String source;

  /// The source's identifier for the movie
  final String sourceId;

  factory MovieEntity.empty() => MovieEntity(
    isAdult: false,
    isCached: false,
    isFavorite: false,
    rating: Decimal.fromInt(5),
    voteCount: 100,
    genres: ["Action", "Adventure"],
    backdropPath: "",
    originalLanguage: "en",
    originalTitle: "Movie Title",
    overview: "A brief overview of the movie.",
    posterPath: "",
    source: "",
    sourceId: "",
  );

  @override
  List<Object?> get props => [
    isAdult,
    isCached,
    isFavorite,
    rating,
    voteCount,
    genres,
    backdropPath,
    originalLanguage,
    originalTitle,
    overview,
    posterPath,
    source,
    sourceId,
  ];
}
