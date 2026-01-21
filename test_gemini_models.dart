
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  final apiKey = 'AIzaSyCC7qyU1EEJ-0_uqNTWkkuwagVLN-YabSw';
  
  if (apiKey == 'AIzaSy...') {
    print('Please replace with your actual API key');
    return;
  }

  try {
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    // There isn't a direct "listModels" method on the GenerativeModel class itself easily accessible in a simple script without using the REST API directly or specific library features if exposed. 
    // However, the error message suggests "Call ListModels to see the list...".
    // The library might not expose listModels directly in the high-level API.
    
    // Instead, let's try to generate content with a few common model names to see which one works.
    
    final candidates = [
      'gemini-1.5-flash',
      'gemini-1.5-pro',
      'gemini-1.0-pro',
      'gemini-pro',
    ];

    print('Checking models...');
    
    for (final m in candidates) {
        try {
            print('Trying $m...');
            final tempModel = GenerativeModel(model: m, apiKey: apiKey);
            final response = await tempModel.generateContent([Content.text('Test')]);
            print('SUCCESS: $m works! Response: ${response.text}');
            return; // Found a working one
        } catch (e) {
            print('FAILED: $m. Error: $e');
        }
    }
    
    print('All candidates failed.');

  } catch (e) {
    print('Error: $e');
  }
}
