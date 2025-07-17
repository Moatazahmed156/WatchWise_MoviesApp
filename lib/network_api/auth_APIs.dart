import 'package:http/http.dart' as http;
import 'dart:convert';
import 'variables.dart';

class AuthService {
  static Future<Map<String, dynamic>> authRequest({
    required String endpoint,          // 'login' or 'signup'
    required String email,
    required String password,
    String? name,                      // Optional: for signup
  }) async {
    final url = Uri.parse('https://${variables.myIp}/$endpoint');

    final body = {
      'email': email,
      'password': password,
      if (endpoint == 'signup' && name != null) 'name': name,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'message': data['message'] ?? 'Request failed',
        };
      }
    } catch (e) {
      print('Auth request error: $e');
      return {
        'success': false,
        'message': 'Network error, please try again',
      };
    }
  }
}
