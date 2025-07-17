import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movies_app/network_api/delete_from_fav_list.dart';
import 'package:movies_app/src/app_colors.dart';
import 'package:shimmer/shimmer.dart';
import '../network_api/get_movie_by_id.dart';
import '../screens/other/movie_details.dart';
import 'movie_category_card.dart';

class WishListCard extends StatefulWidget {
  const WishListCard({
    super.key,
    required this.movieid,
    required this.id,
    required this.onDelete,
  });
  final int movieid;
  final int id;
  final VoidCallback onDelete;

  @override
  State<WishListCard> createState() => _WishListCardState();
}

class _WishListCardState extends State<WishListCard> {
  late Future<Map<String, dynamic>> _MovieDetailsFuture;

  void initState() {
    super.initState();
    _MovieDetailsFuture = fetchMovieById(widget.movieid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _MovieDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[400]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,  // Full width
              height: 130,             // Fixed height
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final movie = snapshot.data!;
          final title = movie['title'] ?? 'No Title';
          final List<dynamic> genres = movie['genres'];
          final coverURL =
              movie['poster_path'] != null
                  ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                  : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';
          final rating = movie['vote_average']?.toStringAsFixed(1) ?? "N/A";
          final releaseYear =
              (movie['release_date'] as String?)?.split('-').first ?? "Unknown";
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetails(id: widget.movieid),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColor.primaryColor,
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(
                children: [
                  Image.network(
                    coverURL,
                    height: 130,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 180,
                                child: Text(
                                  "${title.length > 25 ? title.substring(0, 24) + '...' : title}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 20,
                                    color: Colors.orange,
                                  ),
                                  Text(
                                    "$rating",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    "$releaseYear",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  for (int i = 0; i < min(genres.length, 2); i++)
                                    MovieCategoryCard(name: genres[i]['name']),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () async {
                              await deleteFavMovie(widget.id);
                              widget.onDelete();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.grey[300],
                              size: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
