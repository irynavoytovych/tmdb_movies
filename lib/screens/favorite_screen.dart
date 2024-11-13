import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/movie.dart';
import 'package:tmdb/notifiers/authorization_notifier.dart';
import 'package:tmdb/notifiers/favorites_notifier.dart';
import 'package:tmdb/screens/movie_details_screen.dart';
import 'package:tmdb/widgets/home_movie_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

String callbackUrl = 'https://authentication_callback/';

class _FavoriteScreenState extends State<FavoriteScreen> {
  late WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (change) {
          print(change.url);

          if (change.url?.startsWith(callbackUrl) == true) {
            Uri callbackUri = Uri.parse(change.url!);
            String requestToken = callbackUri.queryParameters['request_token']!;
            bool approved =
                bool.parse(callbackUri.queryParameters['approved']!);

            if (approved) {
              final authorizationNotifier =
                  context.read<AuthorizationNotifier>();

              authorizationNotifier.authenticateUser(token: requestToken);
            }

            print(
              'Request ${approved ? 'approved' : 'denied'} for token $requestToken',
            );
          }
        },
      ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authorizationNotifier = context.watch<AuthorizationNotifier>();
    final favoritesNotifier = context.watch<FavoritesNotifier>();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: const Text('Favorite movies')),
      body: authorizationNotifier.authenticated
          ? FutureBuilder(
              future: favoritesNotifier.getFavorites(page: 1),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<Movie> movies = snapshot.data!;

                return GridView.builder(
                  itemCount: movies.length,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 120 / 186,
                    mainAxisSpacing: 24,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    Movie movie = movies[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                            return MovieDetailsScreen(movie: movie);
                          }),
                        );
                      },
                      child: HomeMovieWidget(movie: movie),
                    );
                  },
                );
              },
            )
          : FutureBuilder(
              future: tmdbApi.getAuthorizationToken(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error?.toString() ?? '');
                }

                if (snapshot.hasData) {
                  String token = snapshot.data!.requestToken;

                  controller.loadRequest(
                    Uri.parse(
                        'https://www.themoviedb.org/authenticate/$token?redirect_to=$callbackUrl'),
                  );
                  // snapshot.data?.requestToken
                  return WebViewWidget(controller: controller);
                }
                return const CircularProgressIndicator();
              },
            ),
    );
  }
}
