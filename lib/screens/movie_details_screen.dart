import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tmdb/main.dart';
import 'package:tmdb/models/actor.dart';
import 'package:tmdb/models/movie.dart';
import 'package:tmdb/models/movie_details.dart';
import 'package:tmdb/notifiers/authorization_notifier.dart';
import 'package:tmdb/notifiers/favorites_notifier.dart';
import 'package:tmdb/screens/actor_details_screen.dart';
import 'package:tmdb/widgets/actor_widget.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreen();
}

class _MovieDetailsScreen extends State<MovieDetailsScreen> {
  bool _isFavorite = false;

  late Future<MovieDetails> _movieDetailsFuture;

  @override
  void initState() {
    super.initState();

    _movieDetailsFuture = tmdbApi
        .getMovieDetails(
      movieId: widget.movie.id,
      sessionId: context.read<AuthorizationNotifier>().sessionId,
    )
        .then(
      (movie) {
        setState(
          () {
            _isFavorite = movie.accountStates?.favorite ?? false;
          },
        );

        return movie;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: FutureBuilder(
        future: _movieDetailsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          MovieDetails movieDetails = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 320,
                      child: Image.network(
                        widget.movie.backdropPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SafeArea(
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: const Offset(2, 2))
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                const Color.fromARGB(100, 33, 33, 33).withOpacity(0.5),
                                const Color.fromARGB(100, 33, 33, 33),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.0, 0.7, 1],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          alignment: Alignment.bottomRight,
                          onPressed: () {
                            final authorizationNotifier =
                                context.read<AuthorizationNotifier>();

                            if (authorizationNotifier.authenticated) {
                              context
                                  .read<FavoritesNotifier>()
                                  .setFavorite(
                                    movieId: widget.movie.id,
                                    favorite: !_isFavorite,
                                  )
                                  .then(
                                (value) {
                                  setState(
                                    () {
                                      _isFavorite = !_isFavorite;
                                    },
                                  );
                                },
                              );
                            }
                          },
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.movie.originalTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          clipBehavior: Clip.none,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.movie.releaseDate,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                '${movieDetails.runtime}m',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                movieDetails.genres
                                    .map((e) => e.name)
                                    .join(', '),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.movie.overview,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Cast',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                  future: tmdbApi.getCast(movieId: widget.movie.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Actor> actors = snapshot.data!;

                      return SizedBox(
                        height: 136,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          scrollDirection: Axis.horizontal,
                          itemCount: actors.length,
                          itemBuilder: (context, index) {
                            Actor actor = actors[index];

                            // return ActorWidget(actor: actor);
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return ActorDetailsScreen(actor: actor);
                                    },
                                  ),
                                );
                              },
                              child: ActorWidget(actor: actor),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 16);
                          },
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Text(
                        '${snapshot.error}\n${snapshot.stackTrace}',
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
