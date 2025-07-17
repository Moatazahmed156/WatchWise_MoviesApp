import 'package:flutter/material.dart';
import 'package:movies_app/components/home/category_card.dart';

class GenreListSection extends StatelessWidget {
  final Future<List<dynamic>> genresFuture;
  final int selectedGenreId;
  final void Function(int) onGenreSelected;
  final bool isNotLoggedIn;

  const GenreListSection({
    super.key,
    required this.genresFuture,
    required this.selectedGenreId,
    required this.onGenreSelected,
    required this.isNotLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FutureBuilder<List<dynamic>>(
        future: genresFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return const Center(child: Text("No categories found."));

          final genres = [
            {"id": -1, "name": "For you"},
            {"id": -2, "name": "Top rating"},
            {"id": -3, "name": "2025"},
            ...snapshot.data!,
          ];

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: genres.length,
            itemBuilder: (context, index) {
              final genre = genres[index];
              if (isNotLoggedIn && genre['id'] == -1) return const SizedBox();

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CategoryCard(
                  name: genre['name'],
                  isSelected: selectedGenreId == genre['id'],
                  onTap: () => onGenreSelected(genre['id']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
