import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/components/home/home_header.dart';
import 'package:movies_app/network_api/get_categories_list.dart';
import 'package:movies_app/network_api/get_movies_by_genre.dart';
import 'package:movies_app/network_api/get_recommended_movies.dart';
import 'package:movies_app/network_api/get_top_raring_movies.dart';
import 'package:movies_app/src/app_colors.dart';

import '../../components/home/genre_list_section.dart';
import '../../components/home/movie_grid_section.dart';
import '../../components/home/pagination_controls.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<dynamic>> _genresFuture;
  late Future<List<dynamic>> _moviesFuture;
  late int _selectedGenreId;
  late bool isNotLoggedIn;
  int page = 1;

  final box = Hive.box("MyData");

  @override
  void initState() {
    super.initState();
    isNotLoggedIn = box.get('id') == null;
    _selectedGenreId = isNotLoggedIn ? -2 : -1;
    _genresFuture = fetchCategoriesList();
    _moviesFuture = isNotLoggedIn
        ? fetchTopRatedMovies(page)
        : fetchRecommendedMovies(page);
  }

  void _onGenreSelected(int genreId) {
    setState(() {
      page = 1;
      _selectedGenreId = genreId;
      _moviesFuture = _getMovieFuture(genreId, page);
    });
  }

  void _changePage(bool isNext) {
    setState(() {
      page += isNext ? 1 : -1;
      _moviesFuture = _getMovieFuture(_selectedGenreId, page);
    });
  }

  Future<List<dynamic>> _getMovieFuture(int genreId, int page) {
    if (genreId == -2) return fetchTopRatedMovies(page);
    if (genreId == -1) return fetchRecommendedMovies(page);
    return fetchMoviesByGenre(genreId, page: page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeHeader(),
            const Padding(
              padding: EdgeInsets.only(left: 12, top: 12, bottom: 5),
              child: Text(
                "Category",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor,
                ),
              ),
            ),
            GenreListSection(
              genresFuture: _genresFuture,
              selectedGenreId: _selectedGenreId,
              onGenreSelected: _onGenreSelected,
              isNotLoggedIn: isNotLoggedIn,
            ),
            PaginationControls(
              page: page,
              onPageChanged: _changePage,
              canGoBack: page > 1,
            ),
            MovieGridSection(moviesFuture: _moviesFuture),
          ],
        ),
      ),
    );
  }
}
