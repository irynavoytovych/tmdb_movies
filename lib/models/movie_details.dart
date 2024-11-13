import 'package:tmdb/models/genre.dart';

class MovieDetails {
  final bool adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String? imdbId;
  final List<String>? originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final AccountStates? accountStates;

  MovieDetails({
    required this.adult,
    required this.backdropPath,
    required this.belongsToCollection,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.accountStates,
  });

  MovieDetails.fromJson(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath =
            'https://image.tmdb.org/t/p/w1280${json['backdrop_path']}',
        belongsToCollection = json['belongs_to_collection'] != null
            ? BelongsToCollection.fromJson(json['belongs_to_collection'])
            : null,
        budget = json['budget'],
        genres = (json['genres'] as List<dynamic>)
            .map((e) => Genre.fromJson(e))
            .toList(),
        homepage = json['homepage'],
        id = json['id'],
        imdbId = json['imdb_id'],
        originCountry = (json['origin_country'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = 'https://image.tmdb.org/t/p/w1280${json['poster_path']}',
        productionCompanies = (json['production_companies'] as List<dynamic>)
            .map((e) => ProductionCompany.fromJson(e))
            .toList(),
        productionCountries = (json['production_countries'] as List<dynamic>)
            .map((e) => ProductionCountry.fromJson(e))
            .toList(),
        releaseDate = json['release_date'],
        revenue = json['revenue'],
        runtime = json['runtime'],
        spokenLanguages = (json['spoken_languages'] as List<dynamic>)
            .map((e) => SpokenLanguage.fromJson(e))
            .toList(),
        status = json['status'],
        tagline = json['tagline'],
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'],
        accountStates = json['account_states'] != null
            ? AccountStates.fromJson(json['account_states'])
            : null;
}

class BelongsToCollection {
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;

  BelongsToCollection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        posterPath = json['poster_path'],
        backdropPath = json['backdrop_path'];
}

class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompany({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  ProductionCompany.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        logoPath = json['logo_path'],
        name = json['name'],
        originCountry = json['origin_country'];
}

class ProductionCountry {
  final String iso;
  final String name;

  ProductionCountry({
    required this.iso,
    required this.name,
  });

  ProductionCountry.fromJson(Map<String, dynamic> json)
      : iso = json['iso_3166_1'],
        name = json['name'];
}

class SpokenLanguage {
  final String englishName;
  final String iso;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso,
    required this.name,
  });

  SpokenLanguage.fromJson(Map<String, dynamic> json)
      : englishName = json['english_name'],
        iso = json['iso_639_1'],
        name = json['name'];
}

class AccountStates {
  final bool favorite;
  final bool rated;
  final bool watchlist;

  AccountStates({
    required this.favorite,
    required this.rated,
    required this.watchlist,
  });

  AccountStates.fromJson(Map<String, dynamic> json)
      : favorite = json['favorite'],
        rated = json['rated'],
        watchlist = json['watchlist'];
}
