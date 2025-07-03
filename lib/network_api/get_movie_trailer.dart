import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/network_api/variables.dart';

Future<String?> fetchTrailer(String movieId) async {
  final url = 'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=${variables.TMDB_API_KEY}';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final videos = json['results'];

    for (var video in videos) {
      if (video['site'] == 'YouTube' && video['type'] == 'Trailer') {
        return video['key'];
      }
    }
  } else {
    print('Failed to load trailer: ${response.statusCode}');
  }
  return null;
}

