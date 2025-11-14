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
  You are an expert career counselor and adaptive-question generator.

  Your tasks are:
  1. Analyze the student's profile.
  2. Suggets 3 to 5 university careers with short explanations.
  3. Generate one adaptive follow-up question based on the studen'ts previous answers.

  Student profile data:
  - Interests: {interests}
  - Skills: {skills}
  - Personality: {personality}
  - Favorite subjects: {subjects}
  - Preferences: {preferences}

  Rules for adaptive questions:
  - The question must be personalized to what the student wrote.
  - Do NOT repeat a question the student already answered.
  - Focus on clarifying motivations, strengths, or preferences.
  - Only generate **one** adaptive question.

  Final output format: 
  ### Career Recommendations
  1. Career Name - short explanation why it fits.
  2. Career Name - explanation.
  3. Career Name - explanation.

  ### Adaptive Question
  Your adaptive question here.
  ''';
}
