import 'package:careerpathai/data/repositories/gemini_repository_impl.dart';

class GeminiConfig {
  static String? _cachedModel;
  static final _repo = GeminiRepositoryImpl();

  static Future<String> getModelName() async {
    if (_cachedModel != null) return _cachedModel!;
    final model = await _repo.getActiveModel();
    _cachedModel = model ?? 'gemini-2.5-pro';
    return _cachedModel!;
  }

  static Future<void> setModelName(String modelName) async {
    await _repo.setActiveModel(modelName);
    _cachedModel = modelName;
  }
}
