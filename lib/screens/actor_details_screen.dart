import 'package:flutter/material.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/actor.dart';
import 'package:tmdb/models/actor_details.dart';
import 'package:tmdb/models/movie_credits.dart';
import 'package:tmdb/screens/movie_details_screen.dart';
import 'package:tmdb/widgets/movie_credits_widget.dart';


class ActorDetailsScreen extends StatelessWidget {
  final Actor actor;

  const ActorDetailsScreen({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: FutureBuilder(
          future: tmdbApi.getActorInformation(actor.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ActorDetails actorDetails = snapshot.data!;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(
                              actor.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22,
                              ),
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
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 7),
                            height: 150,
                            width: 125,
                            child: actor.profilePath != null
                                ? Image.network(
                                    actor.profilePath!,
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.account_circle,
                                    color: Colors.grey[700],
                                    size: 92,
                                  ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, bottom: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Stage Name: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          actorDetails.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Text(
                                        'Character: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          actor.character,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Text(
                                        'Birthday: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Expanded(
                                        child: actorDetails.birthday != null
                                            ? Text(
                                                actorDetails.birthday!,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : const Text('Unknown'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    'Place of birth: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  actorDetails.placeOfBirth != null
                                      ? Text(
                                          actorDetails.placeOfBirth!,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : const Text('Unknown'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Center(
                        child: Text(
                          'Known from',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      FutureBuilder(
                        future: tmdbApi.getMovieCredits(actor.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<MovieCredits> movies = snapshot.data!;

                            return SizedBox(
                              height: 500,
                              child: ListView.separated(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                scrollDirection: Axis.vertical,
                                itemCount: movies.length,
                                itemBuilder: (context, index) {
                                  MovieCredits movie = movies[index];

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return MovieDetailsScreen(
                                              movie: movie,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child:
                                        MovieCreditsWidget(movieCredits: movie),
                                  );

                                  // return MovieCreditsWidget(
                                  //   movieCredits: movie,
                                  // );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 16);
                                },
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Text(
                              '${snapshot.error}\n${snapshot.stackTrace}',
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
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
      ),
    );
  }
}
