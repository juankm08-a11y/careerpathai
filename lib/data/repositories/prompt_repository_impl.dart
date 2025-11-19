import 'package:careerpathai/domain/repositories/prompt_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PromptRepositoryImpl implements PromptRepository {
  final SupabaseClient _supabase;

  PromptRepositoryImpl({SupabaseClient? supabase})
      : _supabase = supabase ?? Supabase.instance.client;

  @override
  Future<String?> getActivePrompt() async {
    try {
      final response = await _supabase
          .from('ai_prompts')
          .select('prompt_text')
          .eq('is_active', true)
          .limit(1)
          .maybeSingle();

      if (response != null && response['prompt_text'] != null) {
        return response['prompt_text'] as String;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> setActivePrompt(int promptId) async {
    try {
      await _supabase.from('ai_prompts').update({'is_active': false});

      await _supabase
          .from('ai_prompts')
          .update({'is_active': true}).eq('id', promptId);
    } catch (e) {
      return;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getAllPrompts() async {
    try {
      final data = await _supabase.from('ai_prompts').select();
      return List<Map<String, dynamic>>.from(data);
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> savePrompt(
    String title,
    String description,
    String content,
  ) async {
    try {
      await _supabase.from('ai_prompts').insert({
        'title': title,
        'description': description,
        'prompt_text': content,
        'is_active': false,
      });
    } catch (_) {}
  }

  @override
  Future<void> updatePrompt(
    int id,
    String title,
    String description,
    String content,
  ) async {
    try {
      await _supabase.from('ai_prompts').update({
        'title': title,
        'description': description,
        'prompt_text': content,
      }).eq('id', id);
    } catch (_) {}
  }
}
