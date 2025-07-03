import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movies_app/components/movie_category_card.dart';
import 'package:movies_app/network_api/add_movie_to_fav.dart';
import 'package:movies_app/network_api/delete_from_fav_list.dart';
import 'package:movies_app/network_api/get_movie_by_id.dart';
import 'package:movies_app/network_api/get_movie_trailer.dart';
import 'package:movies_app/network_api/is_fav_movie.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../src/app_colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'login.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({super.key, required this.id});
  final String id;
  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  late Future<Map<String, dynamic>> _MovieDetailsFuture;
  late Future<String?> TrailerKey;
  late Future<Map<String, dynamic>> favResult = Future.value({
    'isFavorite': false,
    'favData': null,
  });
  @override
  void initState() {
    super.initState();
    _MovieDetailsFuture = fetchMovieById(widget.id);
    TrailerKey = fetchTrailer(widget.id);
    favResult = checkIsFav(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var box = Hive.box("MyData");
    bool isNotLogedin = box.get('id') == null;
    return FutureBuilder<Map<String, dynamic>>(
      future: _MovieDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final movie = snapshot.data!;
          final title = movie['title'] ?? 'No Title';
          final overView = movie['overview'];
          final List<dynamic> genres = movie['genres'];
          final coverURL =
          movie['poster_path'] != null
              ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
              : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg';
          final rating = movie['vote_average']?.toStringAsFixed(1) ?? "N/A";
          final releaseYear =
              (movie['release_date'] as String?)?.split('-').first ?? "Unknown";
          final isAdult = movie["adult"];
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _MovieDetailsFuture = fetchMovieById(widget.id);
                  TrailerKey = fetchTrailer(widget.id);
                  favResult = checkIsFav(widget.id);
                });
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                          ),
                          child: Image.network(
                            coverURL,
                            height: 500,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.2), // Top color
                                Colors.black.withOpacity(0.7), // Bottom color
                              ],
                            ),
                          ),
                        ),

                        Positioned(
                          top: 30,
                          left: 5,
                          child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 6,
                                horizontal: 2,
                              ),
                            ),
                            onPressed: () async {
                              final key = await TrailerKey;
                              if (key != null) {
                                final Uri trailerUrl = Uri.parse(
                                  'https://www.youtube.com/watch?v=$key',
                                );

                                try {
                                  if (await canLaunchUrl(trailerUrl)) {
                                    await launchUrl(
                                      trailerUrl,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  } else {
                                    throw 'Could not launch $trailerUrl';
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Error loading trailer'),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Trailer not available'),
                                  ),
                                );
                              }
                            },
                            child: Icon(
                              Icons.whatshot,
                              size: 50,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 10,
                          right: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Text(
                                "${title}",
                                style: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                spacing: 10,
                                children: [
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
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 25),
                                      Text(
                                        "$releaseYear",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 35),
                                  if (isAdult)
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        "+18",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Row(
                                children: [
                                  for (
                                  int i = 0;
                                  i < min(genres.length, 3);
                                  i++
                                  )
                                    MovieCategoryCard(name: genres[i]['name']),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 5,
                        children: [
                          Text(
                            "StoryLine",
                            style: TextStyle(
                              fontSize: 25,
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$overView",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: FutureBuilder<Map<String, dynamic>>(
                future: favResult,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error checking favorites"));
                  } else if (snapshot.hasData) {
                    final bool isFavorite = snapshot.data!['isFavorite'];
                    final favData = snapshot.data!['favData'];

                    return TextButton(
                      onPressed: () async {
                        if (isNotLogedin) {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                              title: const Text('Login Required'),
                              content: const Text('Please Login First.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Login(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed:
                                      () => Navigator.of(context).pop(),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                          return;
                        } else {
                          if (isFavorite && favData != null) {
                            await deleteFavMovie(favData['id']);
                            setState(() {
                              favResult = Future.value({
                                'isFavorite': false,
                                'favData': null,
                              });
                            });
                          } else {
                            await addMovieToFav(widget.id);
                            setState(() {
                              favResult = checkIsFav(widget.id);
                            });
                          }
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                        isFavorite ? Colors.red : AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        isFavorite ? 'Remove from my list' : 'Add to my list',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ),
          );
        }
      },
    );
  }
}


