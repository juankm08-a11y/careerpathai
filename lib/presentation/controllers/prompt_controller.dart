import 'package:careerpathai/data/models/prompt_model.dart';
import 'package:careerpathai/data/repositories/prompt_repository_impl.dart';
import 'package:careerpathai/services/prompt_service.dart';
import 'package:flutter/foundation.dart';

class PromptController with ChangeNotifier {
  final PromptService _service = PromptService(
    repository: PromptRepositoryImpl(),
  );

  List<PromptModel> prompts = [];
  int? activePromptId;
  bool loading = false;

  Future<void> loadPrompts() async {
    loading = true;
    notifyListeners();

    prompts = await _service.getAllPrompts();

    final active = prompts.firstWhere(
      (p) => p.isActive,
      orElse: () => PromptModel(
        id: 0,
        title: '',
        description: '',
        content: '',
        isActive: false,
      ),
    );

    if (active.id != 0) activePromptId = active.id;

    loading = false;
    notifyListeners();
  }

  Future<void> activatePrompt(int id) async {
    await _service.setActivePrompt(id);
    activePromptId = id;
    notifyListeners();
  }

  Future<void> addPrompt({
    required String title,
    required String description,
    required String content,
  }) async {
    await _service.createPrompt(
      title: title,
      description: description,
      content: content,
    );
  }

  Future<void> editPrompt({
    required int id,
    required String title,
    required String description,
    required String content,
  }) async {
    await _service.updatePrompt(
      id: id,
      title: title,
      description: description,
      content: content,
    );
  }
}
