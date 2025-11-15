import '../../domain/entities/career_entity.dart';

class CareerModel extends CareerEntity {
  CareerModel({
    required super.id,
    required super.title,
    required super.description,
    super.skills = const [],
    super.score = 0.0,
    double? skillsMatch,
    String? marketDemand,
    List<String>? route,
    List<String>? tags,
    String? workEnvironment,
    double? employability,
    double? avgSalary,
    String? trend,
    Map<String, dynamic>? purpose,
  }) : super(
         skillsMatch: skillsMatch,
         marketDemand: marketDemand,
         route: route,
         tags: tags,
         workEnvironment: workEnvironment,
         employability: employability,
         avgSalary: avgSalary,
         trend: trend,
         purpose: purpose,
       );

  factory CareerModel.fromMap(Map<String, dynamic> map) {
    return CareerModel(
      id: map['id']?.toString() ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      skills: (map['skills'] is List)
          ? List<String>.from(map['skills'])
          : <String>[],
      score: (map['score'] != null) ? (map['score'] as num).toDouble() : 0.0,
      skillsMatch: (map['skills_match'] != null)
          ? (map['skills_match'] as num).toDouble()
          : null,
      marketDemand: map['market_demand']?.toString(),
      route: (map['route'] is List) ? List<String>.from(map['route']) : null,
      tags: (map['tags'] is List) ? List<String>.from(map['tags']) : null,
      workEnvironment: map['work_environment']?.toString(),
      employability: (map['employability'] != null)
          ? (map['employability'] as num).toDouble()
          : null,
      avgSalary: (map['avg_salary'] != null)
          ? (map['avg_salary'] as num).toDouble()
          : null,
      trend: map['trend']?.toString(),
      purpose: map['purpose'] is Map
          ? Map<String, dynamic>.from(map['meta'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'skills': skills,
      'score': score,
      'skills_match': skillsMatch,
      'market_demand': marketDemand,
      'route': route,
      'tags': tags,
      'work_environment': workEnvironment,
      'employability': employability,
      'avg_salary': avgSalary,
      'trend': trend,
      'purpose': purpose,
    };
  }
}
