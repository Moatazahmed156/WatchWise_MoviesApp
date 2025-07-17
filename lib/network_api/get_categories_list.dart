import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/network_api/variables.dart';

Future<List<dynamic>> fetchCategoriesList() async {

  final url = Uri.parse('https://api.themoviedb.org/3/genre/movie/list?api_key=${variables.TMDB_API_KEY}');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> results = jsonData['genres'];
    return results;
  } else {
    throw Exception('Failed to load categories list');
  }
}
