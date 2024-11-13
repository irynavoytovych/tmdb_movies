import 'package:flutter/material.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/movie.dart';
import 'package:tmdb/screens/movie_details_screen.dart';
import 'package:tmdb/widgets/home_movie_widget.dart';

class TopRatedMoviesScreen extends StatelessWidget {
  const TopRatedMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 16),
                  child: const Text(
                    'Top Rated',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16,
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
            Expanded(
              child: FutureBuilder(
                future: tmdbApi.getMoviesTopRated(page: 1),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  List<Movie> movies = snapshot.data!;

                  return GridView.builder(
                    itemCount: movies.length,
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
