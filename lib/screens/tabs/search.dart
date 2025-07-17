import 'package:flutter/material.dart';
import '../../components/search/search_header.dart';
import '../../components/search/search_results.dart';
import '../../network_api/search_movie_by_title.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<List<dynamic>>? searchMoviesFuture;

  void onSearchChanged(String query) {
    final trimmed = query.trim();
    if (trimmed.length > 2) {
      setState(() {
        searchMoviesFuture = searchMovies(trimmed);
      });
    } else {
      setState(() {
        searchMoviesFuture = null;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchHeader(onChanged: onSearchChanged),
          Expanded(child: SearchResults(future: searchMoviesFuture)),
        ],
      ),
    );
  }
}
