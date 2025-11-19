abstract class GeminiRepository {
  Future<String?> getActiveModel();

  Future<void> setActiveModel(String modelName);
}
