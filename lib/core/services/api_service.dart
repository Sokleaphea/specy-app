import 'dart:convert';
import '../constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  ApiService({this.baseUrl = ApiConstants.baseUrl});

  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception('Failed to load data: ${response.statusCode} ${response.reasonPhrase},');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
