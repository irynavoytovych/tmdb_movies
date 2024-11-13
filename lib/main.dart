import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/models/genre.dart';
import 'package:tmdb/notifiers/authorization_notifier.dart';
import 'package:tmdb/notifiers/favorites_notifier.dart';
import 'package:tmdb/screens/landing_screen.dart';
import 'package:tmdb/screens/home_screen.dart';
import 'package:tmdb/services/session_store.dart';
import 'package:tmdb/services/tmdb_api.dart';

late TmdbRepository tmdbApi;

late Map<int, String> genres;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tmdbApi = TmdbRepository(
    apiKey: const String.fromEnvironment('tmdb_api_key'),
    language: 'us',
  );

  genres = await tmdbApi.getGenres().then((genresList) {
    Map<int, String> genres = {};

    for (Genre genre in genresList) {
      genres[genre.id] = genre.name;
    }

    return genres;
  });

  RestoredSession? session = await SessionStore().restoreSession();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthorizationNotifier>(
          create: (context) => AuthorizationNotifier(
            sessionId: session?.sessionId,
            user: session?.user,
          ),
        ),
        ChangeNotifierProvider<FavoritesNotifier>(
          create: (context) => FavoritesNotifier(
            context.read<AuthorizationNotifier>(),
          ),
        ),
        Provider<MoviesData>(create: (context) => MoviesData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.yellowAccent,
            brightness: Brightness.dark,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            unselectedLabelStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    ),
  );
}
