class PromptModel {
  final int id;
  final String title;
  final String description;
  final String content;
  final bool isActive;

  PromptModel({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.isActive,
  });

  factory PromptModel.fromMap(Map<String, dynamic> map) {
    return PromptModel(
      id: map['id'] as int,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      content: map['prompt_text'] ?? '',
      isActive: map['is_active'] == true || map['is_active'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'prompt_text': content,
      'is_active': isActive,
    };
  }
}
