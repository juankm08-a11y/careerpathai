class CareerEntity {
  final String id;
  final String title;
  final String description;
  final List<String> skills;
  final double score;
  final String jobOpportunities;

  final double? skillsMatch;
  final String? marketDemand;
  final List<String>? route;
  final List<String>? tags;
  final String? workEnvironment;
  final double? employability;
  final double? avgSalary;
  final String? trend;
  final Map<String, dynamic>? purpose;

  CareerEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.jobOpportunities,
    this.skills = const [],
    this.score = 0.0,
    this.skillsMatch,
    this.marketDemand,
    this.route,
    this.tags,
    this.workEnvironment,
    this.employability,
    this.avgSalary,
    this.trend,
    this.purpose,
  });
}
