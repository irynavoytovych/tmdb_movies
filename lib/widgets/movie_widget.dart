import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tmdb/models/movie.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;

  const MovieWidget ({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 126,
      decoration: BoxDecoration(
        color: const Color(0xFF0F2134),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 126,
            child: Image.network(
              movie.posterPath,
              alignment: Alignment.centerLeft,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.releaseDate,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white38,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RatingBar.builder(
                    initialRating: movie.voteAverage != null
                        ? movie.voteAverage! / 2
                        : 0,
                    ignoreGestures: true,
                    allowHalfRating: true,
                    itemSize: 18,
                    itemCount: 5,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    unratedColor: Colors.grey[800],
                    onRatingUpdate: (_) {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          const SizedBox(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 12, right: 12),
                child: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}