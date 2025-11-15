import 'package:careerpathai/domain/repositories/prompt_repository.dart';

class PromptService {
  final PromptRepository repository;

  PromptService({required this.repository});

  Future<String?> getActivePrompt() {
    return repository.getActivePrompt();
  }

  Future<void> setActivePrompt(int id) {
    return repository.setActivePrompt(id);
  }

  Future<List<Map<String, dynamic>>> getAllPrompts() {
    return repository.getAllPrompts();
  }

  Future<void> createPrompt({
    required String title,
    required String description,
    required String content,
  }) {
    return repository.savePrompt(title, description, content);
  }

  Future<void> updatePrompt({
    required int id,
    required String title,
    required String description,
    required String content,
  }) {
    return repository.updatePrompt(id, title, description, content);
  }
}
