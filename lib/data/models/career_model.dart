import '../../domain/entities/career_entity.dart';

class CareerModel extends CareerEntity {
  CareerModel({
    required super.id,
    required super.title,
    required super.description,
    super.skills = const [],
    super.score = 0.0,
  });

  factory CareerModel.fromMap(Map<String, dynamic> map) {
    return CareerModel(
      id: map['id']?.toString() ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      skills: (map['skills'] is List)
          ? List<String>.from(map['skills'])
          : <String>[],
      score: (map['score'] != null) ? (map['score'] as num).toDouble() : 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'skills': skills,
      'score': score,
    };
  }
}
