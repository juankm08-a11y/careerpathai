import 'package:careerpathai/core/config/gemini_config.dart';
import 'package:careerpathai/core/config/prompt_config.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static Future<GenerativeModel> _initModel() async {
    final modelName = await GeminiConfig.getModelName();
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    return GenerativeModel(model: modelName, apiKey: apiKey);
  }

  static Future<String> getCareerRecommendations(
    Map<String, dynamic> profile,
  ) async {
    final model = await _initModel();

    final promptTemplate = await PromptConfig.getPromptText();

    final promt = promptTemplate
        .replaceAll('{interests}', (profile['interests'] as List).join(', '))
        .replaceAll('{skills}', (profile['skills'] as List).join(', '))
        .replaceAll('{personality}', profile['personality'])
        .replaceAll('{subjects}', profile['favoriteSubjects']);

    final response = await model.generateContent([Content.text(promt)]);
    return response.text ?? 'No se puedieron generar recomendaciones';
  }
}
