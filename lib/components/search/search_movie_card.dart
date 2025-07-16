import 'package:flutter/material.dart';
import 'package:movies_app/screens/other/movie_details.dart';

class SearchMovieCard extends StatelessWidget {
  const SearchMovieCard({
    super.key,
    required this.coverURL,
    required this.title,
    required this.movieId,
    required this.year,
  });

  final String coverURL;
  final String title;
  final String movieId;
  final String year;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(id: movieId),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xff5e5db6),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            // Movie poster
            Image.network(
              (coverURL != "N/A" && coverURL.isNotEmpty)
                  ? coverURL
                  : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
              height: 120,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                  height: 120,
                  width: 100,
                  fit: BoxFit.cover,
                );
              },
            ),
            const SizedBox(width: 10),

            // Movie title and year
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    year,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
