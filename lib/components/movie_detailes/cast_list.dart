import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_detailes/actor_card.dart';

class CastListSection extends StatelessWidget {
  final Future<List<dynamic>> CastFuture;

  const CastListSection({
    super.key,
    required this. CastFuture,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: FutureBuilder<List<dynamic>>(
        future:  CastFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return const Center(child: Text("No categories found."));

          final cast = [...snapshot.data!];

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (context, index) {
              final actor = cast[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ActorCard(
                  name: actor['name'],
                  profilePath: actor["profile_path"]?? "null",
                  character: actor["character"],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
