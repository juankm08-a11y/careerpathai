import 'package:careerpathai/domain/repositories/gemini_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GeminiRepositoryImpl implements GeminiRepository {
  final SupabaseClient _supabase;

  GeminiRepositoryImpl({SupabaseClient? supabase})
      : _supabase = supabase ?? Supabase.instance.client;

  @override
  Future<String?> getActiveModel() async {
    final response = await _supabase
        .from('ai_models')
        .select('model_name')
        .eq('is_active', true)
        .limit(1)
        .maybeSingle();

    if (response != null && response['model_name'] != null) {
      return response['model_name'] as String;
    }
    return null;
  }

  @override
  Future<void> setActiveModel(String modelName) async {
    await _supabase
        .from('ai_models')
        .update({'is_active': false}).neq('model_name', modelName);

    await _supabase
        .from('ai_models')
        .update({'active': true}).eq('model_name', modelName);
  }
}
