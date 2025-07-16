import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/network_api/variables.dart';

Future<List<dynamic>> fetchMovieCast(String movieId) async {
  final response = await http.get(Uri.parse(
    'https://api.themoviedb.org/3/movie/$movieId/credits?language=en-US&api_key=${variables.TMDB_API_KEY}',
  ));
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> results = jsonData['cast'];
    return results;
  } else {
    throw Exception('Failed to load movie Translation');
  }
}