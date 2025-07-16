import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/network_api/variables.dart';



Future<Map<String, dynamic>> fetchMovieById(String movieId) async {
  final response = await http.get(Uri.parse(
    'https://api.themoviedb.org/3/movie/$movieId?api_key=${variables.TMDB_API_KEY}',
  ));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load movie details');
  }
}
