import 'dart:convert';
import 'package:http/http.dart' as http;
import './variables.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<List<Map<String, dynamic>>> fetchRecommendedMovies(int page) async {
  var box = Hive.box("MyData");
  int id = box.get('id') ?? -1;

  final response = await http.get(
    Uri.parse('https://${variables.myIp}/recommendations/$id'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    List<Map<String, dynamic>> allData = data.cast<Map<String, dynamic>>();

    const int pageSize = 20;
    final int start = (page - 1) * pageSize;
    final int end = start + pageSize;
    if (start >= allData.length) return [];
    return allData.sublist(
      start,
      end > allData.length ? allData.length : end,
    );
  } else {
    throw Exception('Failed to load recommendations');
  }
}
