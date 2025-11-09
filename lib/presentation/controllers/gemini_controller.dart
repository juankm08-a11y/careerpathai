import 'package:careerpathai/services/gemini_service.dart';

class GeminiController {
  Future<String> generateRecommendations(Map<String, dynamic> profile) async {
    try {
      final result = await GeminiService.getCareerRecommendations(profile);
      return result;
    } catch (e) {
      return 'Error al generate recommendations: $e';
    }
  }
}
