import 'dart:convert';
import 'package:http/http.dart' as http;
import './variables.dart';
import 'package:hive_flutter/hive_flutter.dart';



Future<Map<String, dynamic>> checkIsFav(String movieId) async {
  var box = Hive.box("MyData");
  int id = box.get('id') ?? -1;

  final response = await http.get(
    Uri.parse('https://${variables.myIp}/Favorite/$movieId/$id'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    return {
      'isFavorite': data['isFavorite'],
      'favData': data['data'], // might contain id, movieId, userId
    };
  } else {
    throw Exception("Failed to check favorite status");
  }
}
