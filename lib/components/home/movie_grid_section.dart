import 'package:flutter/material.dart';
import 'package:movies_app/components/home/movie_card.dart';

class MovieGridSection extends StatelessWidget {
  final Future<List<dynamic>> moviesFuture;

  const MovieGridSection({
    super.key,
    required this.moviesFuture,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: FutureBuilder<List<dynamic>>(
        future: moviesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return const Center(child: Text("No movies found."));

          final movies = snapshot.data!;

          return GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.65,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: movies
                .map((e) => MovieCard(
              coverURL:
              'https://image.tmdb.org/t/p/w500${e['poster_path']}',
              id: e['id'].toString(),
            ))
                .toList(),
          );
        },
      ),
    );
  }
}
