import 'package:careerpathai/data/repositories/prompt_repository_impl.dart';

class PromptConfig {
  static String? _cachedPrompt;
  static final _repo = PromptRepositoryImpl();

  static Future<String> getPromptText() async {
    if (_cachedPrompt != null) return _cachedPrompt!;
    final prompt = await _repo.getActivePrompt();
    _cachedPrompt = prompt ?? _defaultPrompt;
    return _cachedPrompt!;
  }

  static Future<void> setPromptText(String promptText) async {
    await _repo.setActivePrompt(promptText);
    _cachedPrompt = promptText;
  }

  static const String _defaultPrompt = '''
  You are an expert career counselor. Analyze the following student profile and suggest 3 to 5 possible university careers, briefly explaining why each one fits this person.
  Student profile:
  - Interests: {interests}
  - Skills: {skills}
  - Personality: {personality}
  - Favorite subjects: {subjects}
  Respond in list format, including the career name and a short explanation (no emojis).
  ''';
}
