import 'package:flutter/material.dart';
import 'package:movies_app/screens/other/movie_details.dart';

class TrendingMoviesCard extends StatelessWidget {
  const TrendingMoviesCard({
    super.key,
    required this.id,
    required this.coverURL,
    required this.title,
  });
  final String id;
  final String coverURL;
  final String title;

  @override
  Widget build(BuildContext context) {
    final String safeImageUrl =
        (coverURL.trim().isEmpty || coverURL.toLowerCase() == 'null')
            ? "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"
            : coverURL;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MovieDetails(id: id)),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              safeImageUrl,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Image.network(
                    "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                    width: 300,
                    fit: BoxFit.cover,
                  ),
            ),
          ),
          Container(
            width: 320,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 15,
            right: 10,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
