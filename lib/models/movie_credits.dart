import 'package:tmdb/models/movie.dart';

class MovieCredits extends Movie {
  final String character;

  MovieCredits({
    required super.adult,
    required super.backdropPath,
    required super.genreIds,
    required super.id,
    required super.originalLanguage,
    required super.originalTitle,
    required super.overview,
    required super.popularity,
    required super.posterPath,
    required super.releaseDate,
    required super.title,
    required super.video,
    required super.voteCount,
    required this.character,
  });

  MovieCredits.fromJson(Map<String, dynamic> json)
      : character = json['character'],
        super(
          adult: json['adult'],
          backdropPath:
              'https://image.tmdb.org/t/p/w1280${json['backdrop_path']}',
          genreIds: (json['genre_ids'] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
          id: json['id'],
          originalLanguage: json['original_language'],
          originalTitle: json['original_title'],
          overview: json['overview'],
          popularity: json['popularity'],
          posterPath: 'https://image.tmdb.org/t/p/w1280${json['poster_path']}',
          releaseDate: json['release_date'],
          title: json['title'],
          video: json['video'],
          voteAverage: json['vote_average'],
          voteCount: json['vote_count'],
        );
}
