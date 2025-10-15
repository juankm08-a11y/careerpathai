import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static final model = GenerativeModel(
    model: 'gemini-2.5-pro',
    apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
  );

  static Future<String> getCareerRecommendations(
    Map<String, dynamic> profile,
  ) async {
    final interests = (profile['interests'] as List).join(', ');
    final skills = (profile['skills'] as List).join(', ');
    final personality = profile['personality'];
    final subjects = profile['favoriteSubjects'];

    final prompt =
        '''
  Eres un orientador vocacional experto. Analiza el siguiente perfil y sugiere 3 a 5 carreras universitarias posibles,
  explicando brevemente por qué encajan con la persona.

  Perfil del estudiante:
  - Intereses: $interests
  - Habilidades: $skills 
  - Personalidad: $personality
  - Materias favoritas: $subjects
   
   Responde en formato de lista, con el nombre de la carrera y una breve descripción (sin emojis).
 ''';

    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? 'No se pudieron generar recomendaciones';
  }
}
