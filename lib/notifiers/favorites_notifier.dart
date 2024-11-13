import 'package:flutter/cupertino.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/movie.dart';
import 'package:tmdb/notifiers/authorization_notifier.dart';

class FavoritesNotifier extends ChangeNotifier {
  final AuthorizationNotifier authorizationNotifier;

  FavoritesNotifier(this.authorizationNotifier);

  Future<List<Movie>> getFavorites({required int page}) {
    return tmdbApi.getFavoriteMovies(
      page: 1,
      accountId: authorizationNotifier.user!.id,
      sessionId: authorizationNotifier.sessionId!,
    );
  }

  Future<void> setFavorite({required int movieId, required bool favorite}) {
    return tmdbApi
        .setFavorite(
          id: movieId,
          accountId: authorizationNotifier.user!.id,
          sessionId: authorizationNotifier.sessionId!,
          favorite: favorite,
        )
        .then((value) => notifyListeners());
  }
}
