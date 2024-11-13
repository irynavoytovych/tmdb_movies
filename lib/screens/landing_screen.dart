import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/movie.dart';
import 'package:tmdb/screens/movie_details_screen.dart';
import 'package:tmdb/screens/now_playing_movies_screen.dart';
import 'package:tmdb/screens/popular_movies_screen.dart';
import 'package:tmdb/screens/top_rated_movies_screen.dart';
import 'package:tmdb/screens/upcoming_movies_screen.dart';
import 'package:tmdb/widgets/now_playing_movie_widget.dart';
import 'package:tmdb/widgets/popular_movie_widget.dart';
import 'package:tmdb/widgets/top_rated_movie_widget.dart';
import 'package:tmdb/widgets/upcoming_movie_widget.dart';

class MoviesData {
  Future<List<Movie>> popularMoviesFuture;
  Future<List<Movie>> nowPlayingMoviesFuture;
  Future<List<Movie>> topRatedMoviesFuture;
  Future<List<Movie>> upcomingMoviesFuture;

  MoviesData()
      : popularMoviesFuture = tmdbApi.getPopularMovies(page: 1),
        nowPlayingMoviesFuture = tmdbApi.getMoviesNowPlaying(page: 1),
        topRatedMoviesFuture = tmdbApi.getMoviesTopRated(page: 1),
        upcomingMoviesFuture = tmdbApi.getMoviesUpcoming(page: 1);
}

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Popular movie',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const PopularMoviesScreen();
                            },
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          'See all >',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: context.watch<MoviesData>().popularMoviesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Movie> movies = snapshot.data!;

                      return SizedBox(
                        height: 260,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            Movie movie = movies[index];

                            return SizedBox(
                              width: 180,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return MovieDetailsScreen(movie: movie);
                                    }),
                                  );
                                },
                                child: PopularMovieWidget(movie: movie),
                              ),
                            );
                          },
                          separatorBuilder: (context, snapshot) {
                            return const SizedBox(
                              width: 4,
                            );
                          },
                        ),
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Now Playing',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const NowPlayingMoviesScreen();
                            },
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          'See all >',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: context.watch<MoviesData>().nowPlayingMoviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Movie> movies = snapshot.data!;
                    return SizedBox(
                      height: 260,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          Movie movie = movies[index];
                          return SizedBox(
                            width: 180,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return MovieDetailsScreen(movie: movie);
                                  }),
                                );
                              },
                              child: NowPlayingMovieWidget(movie: movie),
                            ),
                          );
                        },
                        separatorBuilder: (context, snapshot) {
                          return const SizedBox(
                            width: 4,
                          );
                        },
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Top Rated',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const TopRatedMoviesScreen();
                            },
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          'See all >',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: context.watch<MoviesData>().topRatedMoviesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Movie> movies = snapshot.data!;
                      return SizedBox(
                        height: 260,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            Movie movie = movies[index];
                            return SizedBox(
                              width: 180,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return MovieDetailsScreen(movie: movie);
                                    }),
                                  );
                                },
                                child: TopRatedMovieWidget(movie: movie),
                              ),
                            );
                          },
                          separatorBuilder: (context, snapshot) {
                            return const SizedBox(
                              width: 4,
                            );
                          },
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'Upcoming',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const UpcomingMoviesScreen();
                            },
                          ),
                        );
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        child: const Text(
                          'See all >',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: context.watch<MoviesData>().upcomingMoviesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Movie> movies = snapshot.data!;
                      return SizedBox(
                        height: 260,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            Movie movie = movies[index];
                            return SizedBox(
                              width: 180,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return MovieDetailsScreen(movie: movie);
                                    }),
                                  );
                                },
                                child: UpcomingMovieWidget(movie: movie),
                              ),
                            );
                          },
                          separatorBuilder: (context, snapshot) {
                            return const SizedBox(
                              width: 4,
                            );
                          },
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
