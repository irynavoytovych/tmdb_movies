import 'dart:convert';

import 'package:http/http.dart';
import 'package:tmdb/models/actor.dart';
import 'package:tmdb/models/actor_details.dart';
import 'package:tmdb/models/authorization_token.dart';
import 'package:tmdb/models/genre.dart';
import 'package:tmdb/models/movie.dart';
import 'package:tmdb/models/movie_details.dart';
import 'package:tmdb/models/movie_credits.dart';
import 'package:tmdb/models/user.dart';

class TmdbRepository {
  final String apiKey;
  final String language;

  TmdbRepository({
    required this.apiKey,
    required this.language,
  });

  Future<List<Movie>> getPopularMovies({required int page}) async {
    Uri endpointUri = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular'
      '?language=$language',
    );

    Response response = await get(
      endpointUri,
      headers: {'Authorization': 'Bearer $apiKey'},
    );

    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    List<dynamic> results = parsedJson['results'];

    return results.map((e) => Movie.fromJson(e)).toList();
  }

  Future<List<Actor>> getCast({required int movieId}) async {
    Uri endpointUri = Uri.parse(
      'https://api.themoviedb.org/3/movie/$movieId/credits'
      '?language=$language',
    );

    Response response = await get(endpointUri, headers: {
      'Authorization': 'Bearer $apiKey',
    });

    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    List<dynamic> cast = parsedJson['cast'];

    return cast.map((e) => Actor.fromJson(e)).toList();
  }

  Future<List<Genre>> getGenres() async {
    Uri endpointUri = Uri.parse(
      'https://api.themoviedb.org/3/genre/movie/list'
      '?language=$language',
    );

    Response response = await get(endpointUri, headers: {
      'Authorization': 'Bearer $apiKey',
    });

    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    List<dynamic> genres = parsedJson['genres'];

    return genres.map((e) => Genre.fromJson(e)).toList();
  }

  Future<MovieDetails> getMovieDetails({
    required int movieId,
    required String? sessionId,
  }) async {
    String endpointString = 'https://api.themoviedb.org/3/movie/$movieId'
        '?language=$language'
        '&append_to_response=account_states';

    if (sessionId != null) {
      endpointString += '&$sessionId';
    }

    Uri endpointUri = Uri.parse(endpointString);

    Response response = await get(endpointUri, headers: {
      'Authorization': 'Bearer $apiKey',
    });

    Map<String, dynamic> parsedJson = jsonDecode(response.body);

    return MovieDetails.fromJson(parsedJson);
  }

  Future<List<Movie>> getMoviesNowPlaying({required int page}) async {
    Uri endpointUri = Uri.parse(
      'https://api.themoviedb.org/3/movie/now_playing'
      '?language=$language',
    );

    Response response = await get(endpointUri, headers: {
      'Authorization': 'Bearer $apiKey',
    });

    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    List<dynamic> results = parsedJson['results'];

    return results.map((e) => Movie.fromJson(e)).toList();
  }

  Future<List<Movie>> getMoviesTopRated({required int page}) async {
    Uri endpointUri = Uri.parse(
      'https://api.themoviedb.org/3/movie/top_rated'
      '?language=$language',
    );

    Response response = await get(endpointUri, headers: {
      'Authorization': 'Bearer $apiKey',
    });

    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    List<dynamic> results = parsedJson['results'];

    return results.map((e) => Movie.fromJson(e)).toList();
  }

  Future<List<Movie>> getMoviesUpcoming({required int page}) async {
    Uri endpointUri = Uri.parse(
      'https://api.themoviedb.org/3/movie/upcoming'
      '?language=$language',
    );

    Response response = await get(endpointUri, headers: {
      'Authorization': 'Bearer $apiKey',
    });

    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    List<dynamic> results = parsedJson['results'];

    return results.map((e) => Movie.fromJson(e)).toList();
  }

  Future<AuthorizationToken> getAuthorizationToken() async {
    Uri endpointUri = Uri.parse(
      'https://api.themoviedb.org/3/authentication/token/new',
    );

    Response response = await get(
      endpointUri,
      headers: {'Authorization': 'Bearer $apiKey'},
    );

    Map<String, dynamic> parsedJson = jsonDecode(response.body);

    return AuthorizationToken.fromJson(parsedJson);
  }

  Future<String> createSessionId({required String requestToken}) async {
    Uri endpointUri = Uri.parse(
      'https://api.themoviedb.org/3/authentication/session/new',
    );

    Response response = await post(
      endpointUri,
      headers: {'Authorization': 'Bearer $apiKey'},
      body: {
        'request_token': requestToken,
      },
    );

    Map<String, dynamic> parsedJson = jsonDecode(response.body);

    return parsedJson['session_id'];
  }

  Future<User> getUser({required String sessionId}) async {
    Uri endpointUri = Uri.parse(
      'https://api.themoviedb.org/3/account'
      '?session_id=$sessionId',
    );

    Response response = await get(
      endpointUri,
      headers: {'Authorization': 'Bearer $apiKey'},
    );
    Map<String, dynamic> parsedJson = jsonDecode(response.body);

    return User.fromJson(parsedJson);
  }

  Future<List<Movie>> getFavoriteMovies({
    required int page,
    required int accountId,
    required String sessionId,
  }) async {
    Uri endpointUri = Uri.parse(
      'https://api.themoviedb.org/3/account/$accountId/favorite/movies'
      '?language=$language'
      '&page=1'
      '&session_id=$sessionId'
      '&sort_by=created_at.asc',
    );

    Response response = await get(
      endpointUri,
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    List<dynamic> results = parsedJson['results'];

    return results.map((e) => Movie.fromJson(e)).toList();
  }

  Future<void> setFavorite({
    required int id,
    required int accountId,
    required String sessionId,
    required bool favorite,
  }) async {
    Uri endpointUri = Uri.parse(
      'https://api.themoviedb.org/3/account/$accountId/favorite'
      '?session_id=$sessionId',
    );

    await post(
      endpointUri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'media_type': 'movie',
        'media_id': id,
        'favorite': favorite,
      }),
    );
  }

  Future<ActorDetails> getActorInformation(int actorId) async {
    Uri endpointUri = Uri.parse('https://api.themoviedb.org/3/person/$actorId'
        '?person_id=$actorId'
        '&language=$language');

    Response response = await get(
      endpointUri,
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );

    Map<String, dynamic> parsedJson = jsonDecode(response.body);

    return ActorDetails.fromJson(parsedJson);
  }

  Future<List<MovieCredits>> getMovieCredits(int actorId) async {
    Uri endpointUri =
        Uri.parse('https://api.themoviedb.org/3/person/$actorId/movie_credits'
            '?language=$language');

    Response response = await get(
      endpointUri,
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );
    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    List<dynamic> cast = parsedJson['cast'];

    return cast.map((e) => MovieCredits.fromJson(e)).toList();
  }

  Future<List<Movie>> getSearchMovie(String query) async {
    Uri endpointUri = Uri.parse('https://api.themoviedb.org/3/search/movie'
        '?query=$query');

    Response response = await get(
      endpointUri,
      headers: {
        'Authorization': 'Bearer $apiKey',
      },
    );
    Map<String, dynamic> parsedJson = jsonDecode(response.body);
    List<dynamic> results = parsedJson['results'];

    return results.map((e) => Movie.fromJson(e)).toList();
  }
}
