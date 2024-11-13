import 'package:flutter/material.dart';
import 'package:tmdb/models/actor.dart';

class ActorWidget extends StatelessWidget {
  final Actor actor;

  const ActorWidget({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      child: Column(
        children: [
          Container(
            width: 92,
            height: 92,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              // color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
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
          const SizedBox(height: 8),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
