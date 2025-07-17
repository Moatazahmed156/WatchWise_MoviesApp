import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/network_api/variables.dart';

Future<List<dynamic>> searchMovies(String query) async {
  String title = Uri.encodeComponent(query);
  bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(query);
  String language = isArabic ? 'ar' : 'en';
  final url = Uri.parse(
    'https://api.themoviedb.org/3/search/movie?api_key=${variables.TMDB_API_KEY}&query=$title&language=$language',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    final results = data['results'] as List<dynamic>;
    return results;
  } else {
    throw Exception('Failed to fetch movies. Status code: ${response.statusCode}');
  }
}
