import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/network_api/variables.dart';

Future<List<dynamic>> fetchMoviesByGenre(int genreId ,  {int page = 1}) async {
  final url = Uri.parse('https://api.themoviedb.org/3/discover/movie?with_genres=$genreId&page=$page&api_key=${variables.TMDB_API_KEY}');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> results = jsonData['results'];
    return results;
  } else {
    throw Exception('Failed to load popular movies');
  }
}
