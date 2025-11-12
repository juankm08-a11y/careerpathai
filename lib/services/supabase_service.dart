import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<Map<String, dynamic>?> getRecord({
    required String table,
    Map<String, dynamic>? filters,
  }) async {
    final query = _client.from(table).select('*').limit(1);
    if (filters != null) {
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });
    }
  }

  Future<String?> getActivePrompt() async {
    final data = await getRecord(
      table: 'ai_prompts',
      filters: {'is_active': true},
    );
    return data?['prompt_text'] as String?;
  }

  Future<void> setActivePrompt(String promptText) async {
    await _client
        .from('ai_prompts')
        .update({'is_active': false})
        .neq('prompt_text', promptText);

    await _client
        .from('ai_prompts')
        .update({'is_active': true})
        .eq('prompt_text', promptText);
  }
}
