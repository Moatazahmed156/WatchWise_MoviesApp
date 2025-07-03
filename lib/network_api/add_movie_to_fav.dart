import 'dart:convert';
import 'package:http/http.dart' as http;
import './variables.dart';
import 'package:hive_flutter/hive_flutter.dart';



Future<void> addMovieToFav(String movieId) async {
  var box = Hive.box("MyData");
  int id = box.get('id') ?? -1;
  final response = await http.post(
    Uri.parse('https://${variables.myIp}/addToFav'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'userId': id,
      'movieId': movieId,
    }),
  );
  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
  } else {
    return;
  }
}