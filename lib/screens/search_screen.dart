import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/movie.dart';
import 'package:tmdb/screens/movie_details_screen.dart';
import 'package:tmdb/widgets/popular_movie_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {

  late TextEditingController searchController;

  final debouncedSearchRx = BehaviorSubject<String>.seeded('');

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();

    searchController.addListener(() {
      debouncedSearchRx.add(searchController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();

    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: searchController,
              ),
            ),
            StreamBuilder(
              stream: debouncedSearchRx
                  .debounceTime(const Duration(milliseconds: 500))
                  .asyncMap((event) => tmdbApi.getSearchMovie(event)),
              builder: (context, snapshot) {
                if (searchController.text.isEmpty) {
                  return const SizedBox();
                }

                if (snapshot.hasData) {
                  List<Movie> movies = snapshot.data!;

                  if (movies.isEmpty) {
                    return const Text(
                      'Movie not found',
                      style: TextStyle(color: Colors.white),
                    );
                  }

                  return Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                      ),
                      itemBuilder: (context, index) {

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (BuildContext context) {
                                  return MovieDetailsScreen(movie: movies[index]);
                                })
                            );
                          },
                          child: PopularMovieWidget(movie: movies[index]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                      itemCount: movies.length,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Text(snapshot.error!.toString());
                }

                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      )
    );
  }
}