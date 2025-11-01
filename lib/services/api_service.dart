import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  static const String baseUrl = 'https://login-backend-qfso.onrender.com';

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final uri = Uri.parse('$baseUrl/login');
    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      // Try to decode the response body safely
      try {
        final body = jsonDecode(response.body);
        return body is Map<String, dynamic>
            ? body
            : {'success': false, 'message': 'Unexpected response'};
      } catch (_) {
        return {'success': false, 'message': 'Server returned status ${response.statusCode}'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Network error: $e'};
    }
  }
}
