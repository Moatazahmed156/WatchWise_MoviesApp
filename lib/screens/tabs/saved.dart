import 'package:flutter/material.dart';
import 'package:movies_app/components/wish_list_card.dart';
import 'package:movies_app/network_api/get_fav_movies.dart';
import '../../src/app_colors.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../other/login.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  late Future<List<dynamic>> _favMoviesFuture;
  @override
  void initState() {
    super.initState();
    _favMoviesFuture = getFavMovies();
  }
  void refreshFavorites() {
    setState(() {
      _favMoviesFuture = getFavMovies();
    });
  }

@override
  Widget build(BuildContext context) {
  var box = Hive.box("MyData");
  bool isNotLogedin = box.get('id') == null;
  return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "My Favourites",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: AppColor.primaryColor,
                  ),
                ),
                isNotLogedin ? SizedBox(
                  height: 700,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 50,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 10,
                      ),
                      child: Text(
                        "Login first",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ) :
                FutureBuilder<List<dynamic>>(
                  future: _favMoviesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    else if (snapshot.hasError)
                      return Center(child: Text("Error: ${snapshot.error}"));
                    else if (!snapshot.hasData || snapshot.data!.isEmpty)
                      return Column(
                        children: [
                          Center(child: Text("No movies found.")),
                        ],
                      );

                    final movies = snapshot.data!;
                    return ListView.builder(
                      itemCount: movies.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        final movieid  = movie['movieId'];
                        final id  = movie['id'];
                        return WishListCard(movieid: movieid, id: id , onDelete: refreshFavorites,);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
