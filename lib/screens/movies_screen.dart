import 'package:flutter/material.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/movie.dart';
import 'package:tmdb/screens/movie_details_screen.dart';
import 'package:tmdb/widgets/movie_widget.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B3E50),
      body: SafeArea(
        child: FutureBuilder(
          future: tmdbApi.getPopularMovies(page: 1),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            List<Movie> movies = snapshot.data!;

            return ListView.separated(
              itemCount: movies.length,
              padding: const EdgeInsets.all(24),
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
                  child: MovieWidget(movie: movie),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
            );
          },
        ),
      ),
    );
  }
}
