import 'package:flutter/material.dart';
import 'package:movies_app/screens/other/movie_details.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.coverURL, required this.id});

  final String coverURL;
  final String id;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => MovieDetails(id: id,),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 15,
              offset: Offset(4, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Image.network(
          (coverURL.isNotEmpty && coverURL != 'null')
              ? coverURL
              : "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

      ),
    );
  }
}
