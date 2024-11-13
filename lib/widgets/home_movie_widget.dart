import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tmdb/models/movie.dart';

class HomeMovieWidget extends StatefulWidget {
  final Movie movie;

  const HomeMovieWidget({super.key, required this.movie});

  @override
  State<HomeMovieWidget> createState() => _HomeMovieWidgetState();
}

class _HomeMovieWidgetState extends State<HomeMovieWidget> {
  final bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  widget.movie.posterPath,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.movie.originalTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              if (widget.movie.voteAverage != null) ...[
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBar.builder(
                      initialRating: widget.movie.voteAverage!,
                      itemSize: 13,
                      itemCount: 10,
                      allowHalfRating: true,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.purpleAccent,
                      ),
                      onRatingUpdate: (_) {},
                    ),
                    Text(
                      ('(${widget.movie.voteAverage!.toStringAsFixed(1)})'),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    )
                  ],
                ),
              ],
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.movie.releaseDate,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Vote(${widget.movie.voteCount.toString()})',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
