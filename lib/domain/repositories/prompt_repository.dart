abstract class PromptRepository {
  Future<String?> getActivePrompt();

  Future<void> setActivePrompt(int promptId);

  Future<List<Map<String, dynamic>>> getAllPrompts();

  Future<void> savePrompt(String title, String description, String content);

  Future<void> updatePrompt(
    int id,
    String title,
    String description,
    String content,
  );
}
