class Movie {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double? voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
     this.voteAverage,
    required this.voteCount,
  });

  Movie.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath =
            'https://image.tmdb.org/t/p/w1280${json['backdrop_path']}',
        genreIds =
            (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
        id = json['id'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = 'https://image.tmdb.org/t/p/w1280${json['poster_path']}',
        releaseDate = json['release_date'],
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'];
}
