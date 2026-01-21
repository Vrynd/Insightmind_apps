
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  final apiKey = 'AIzaSyCC7qyU1EEJ-0_uqNTWkkuwagVLN-YabSw';
  final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models?key=$apiKey');

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Available models:');
      for (var m in data['models']) {
        if (m['supportedGenerationMethods'].contains('generateContent')) {
           print('- ${m['name']} (Supported Methods: ${m['supportedGenerationMethods']})');
        }
      }
    } else {
      print('Failed to list models. Status: ${response.statusCode}');
      print('Body: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
