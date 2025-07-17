import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/network_api/variables.dart';

Future<List<dynamic>> getFavMovies() async {
  var box = Hive.box("MyData");
  int id = box.get('id') ?? -1;

  final response = await http.get(
    Uri.parse('https://${variables.myIp}/FavoriteMovies/$id'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {

    final data = jsonDecode(response.body);
    return data;
  } else {
    throw Exception('Failed to get fav movies');
  }
}
