import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/network_api/variables.dart';

Future<List<dynamic>> searchMovies(String query) async {
  final url = Uri.parse('https://www.omdbapi.com/?apikey=${variables.OMDB_API_KEY}&s=$query');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    if (data['Response'] == 'True') {
      // Filter only movies
      final allResults = data['Search'] as List;
      final moviesOnly = allResults.where((item) => item['Type'] == 'movie').toList();
      return moviesOnly;
    } else {
      throw Exception(data['Error'] ?? 'No results found.');
    }
  } else {
    throw Exception('Failed to fetch movies');
  }
}
