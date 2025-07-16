import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/network_api/variables.dart';

Future<Map<String, String>> fetchArabicTranslation(String movieId) async {
  final response = await http.get(Uri.parse(
    'https://api.themoviedb.org/3/movie/$movieId/translations?api_key=${variables.TMDB_API_KEY}',
  ));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> results = jsonData['translations'] ;

    final arabicTranslation = results.firstWhere(
          (translation) => translation['iso_639_1'] == 'ar',
      orElse: () => null,
    );

    if (arabicTranslation != null && arabicTranslation['data'] != null) {
      final data = arabicTranslation['data'];
      final title = data['title'] ?? '';
      final overview = data['overview'] ?? '';
      return {
        'title': title,
        'overview': overview,
      };
    } else {
      throw Exception('Arabic translation not found');
    }
  } else {
    throw Exception('Failed to load movie translation');
  }
}
