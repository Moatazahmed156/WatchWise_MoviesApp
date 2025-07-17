import 'package:flutter/material.dart';
import 'package:movies_app/components/home/profile_dialog.dart';
import 'package:movies_app/components/home/trending_movies_card.dart';
import 'package:movies_app/src/app_colors.dart';

import '../../network_api/get_most_popular_movies.dart';

class HomeHeader extends StatefulWidget {
  HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  late Future<List<dynamic>> _moviesFuture;

  @override
  void initState() {
    super.initState();
    _moviesFuture = fetchPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(height: 350),
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
        ),
        Positioned(
          top: -70,
          right: -80,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Color(0xff5e5db6),
              borderRadius: BorderRadius.circular(500),
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 10,
          right: 10,
          child: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "WatchWise",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ProfileDialog(),
                    );
                  },
                  child: Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
        Positioned(
          top: 130,
          left: 20,
          child: Text(
            "Trending",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          top: 170,
          left: 0,
          right: 0,
          bottom: 0,
          child: FutureBuilder<List<dynamic>>(
            future: _moviesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator());
              else if (snapshot.hasError)
                return Center(child: Text("Error: ${snapshot.error}"));
              else if (!snapshot.hasData || snapshot.data!.isEmpty)
                return Center(child: Text("No movies found."));

              final movies = snapshot.data!;
              return ListView.builder(
                itemCount: movies.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TrendingMoviesCard(id: movie["id"], coverURL: 'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}', title: '${movie['title']}',),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
