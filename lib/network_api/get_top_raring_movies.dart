import 'dart:convert';
import 'package:http/http.dart' as http;
import '../network_api/variables.dart';

Future<List<dynamic>> fetchTopRatedMovies(int page) async {
  final url = Uri.parse(
    'https://api.themoviedb.org/3/movie/top_rated?api_key=${variables.TMDB_API_KEY}&language=en-US&page=$page',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['results'];
  } else {
    throw Exception('Failed to fetch top rated movies from TMDb');
  }
}
