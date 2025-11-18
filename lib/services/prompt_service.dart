import 'package:careerpathai/data/models/prompt_model.dart';
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

  Future<List<PromptModel>> getAllPrompts() async {
    final result = await repository.getAllPrompts();
    return result.map((p) => PromptModel.fromMap(p)).toList();
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
