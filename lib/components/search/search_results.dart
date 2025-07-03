import 'package:flutter/material.dart';
import 'package:movies_app/components/search/search_movie_card.dart';

class SearchResults extends StatelessWidget {
  final Future<List<dynamic>>? future;

  const SearchResults({this.future, super.key});

  @override
  Widget build(BuildContext context) {
    if (future == null) {
      return const Center(child: Text("Start typing to search..."));
    }

    return FutureBuilder<List<dynamic>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No movies found."));
        }

        final movies = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            return SearchMovieCard(
              coverURL: movie["Poster"],
              title: movie["Title"],
              movieId: movie["imdbID"],
              year: movie["Year"],
            );
          },
        );
      },
    );
  }
}
