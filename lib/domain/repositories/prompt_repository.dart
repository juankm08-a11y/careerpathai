abstract class PromptRepository {
  Future<String?> getActivePrompt();

  Future<void> setActivePrompt(String promptText);
}
