import 'package:careerpathai/data/repositories/prompt_repository_impl.dart';
import 'package:careerpathai/services/prompt_service.dart';
import 'package:flutter/foundation.dart';

class PromptController with ChangeNotifier {
  final PromptService _service = PromptService(
    repository: PromptRepositoryImpl(),
  );

  List<Map<String, dynamic>> prompts = [];
  int? activePromptId;
  bool loading = false;

  Future<void> loadPrompts() async {
    loading = true;
    notifyListeners();

    prompts = await _service.getAllPrompts();

    final active = prompts.firstWhere(
      (p) => p['is_active'] == true,
      orElse: () => {},
    );

    if (active.isNotEmpty) activePromptId = active["id"];

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
