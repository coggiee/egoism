import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class EmotionAnalysisService {
  final String _apiUrl =
      "https://api-inference.huggingface.co/models/Copycats/koelectra-base-v3-generalized-sentiment-analysis";
  final String _apiKey = dotenv.get('HUGGING_FACE_API_KEY');

  Future<Map<String, dynamic>> analyzeEmotion(String text) async {
    try {
      final response = await http.post(Uri.parse(_apiUrl),
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'inputs': text}));
      if (response.statusCode == 200) {
        List<dynamic> result = jsonDecode(response.body);
        return result[0][0];
      } else {
        throw Exception('API 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
