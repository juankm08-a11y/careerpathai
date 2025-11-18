import 'dart:convert';

import 'package:careerpathai/services/gemini_service.dart';

class GeminiController {
  Future<List<Map<String, dynamic>>> generateRecommendations(
    Map<String, dynamic> profile,
  ) async {
    try {
      final raw = await GeminiService.getCareerRecommendations(profile);

      final parsed = jsonDecode(raw);

      if (parsed is List) {
        return List<Map<String, dynamic>>.from(parsed);
      } else {
        throw Exception('Invalid JSON format: Expected a List');
      }
    } catch (e) {
      throw 'Error to generate recommendations: $e';
    }
  }
}
