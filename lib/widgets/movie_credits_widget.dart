import 'package:flutter/material.dart';
import 'package:tmdb/models/movie_credits.dart';

class MovieCreditsWidget extends StatelessWidget {
  final MovieCredits movieCredits;

  const MovieCreditsWidget({super.key, required this.movieCredits});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 126,
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 126,
            child: movieCredits.posterPath != null
                ? Image.network(
                    movieCredits.posterPath!,
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.no_photography),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieCredits.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movieCredits.character,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white38,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movieCredits.releaseDate,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
