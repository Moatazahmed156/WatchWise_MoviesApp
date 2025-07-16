import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/network_api/variables.dart';

Future<void> deleteFavMovie(int id) async {

  final response = await http.delete(
    Uri.parse('https://${variables.myIp}/deleteFavMovie/$id'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
  } else {
    throw Exception('Failed to delete movie');
  }
}
