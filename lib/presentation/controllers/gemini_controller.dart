import 'dart:convert';

import 'package:careerpathai/services/gemini_service.dart';

class GeminiController {
  Future<List<Map<String, dynamic>>> generateRecommendations(
    Map<String, dynamic> profile,
  ) async {
    try {
      final rawResponse = await GeminiService.getCareerRecommendations(profile);

      final parsed = jsonDecode(rawResponse);

      if (parsed is List) {
        return List<Map<String, dynamic>>.from(parsed);
      } else {
        throw 'Invalid format: wait to a JSON';
      }
    } catch (e) {
      throw 'Error to generate recommendations: $e';
    }
  }
}
