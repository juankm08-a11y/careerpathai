class CareerEntity {
  final String id;
  final String title;
  final String description;
  final List<String> skills;
  final double score;

  CareerEntity({
    required this.id,
    required this.title,
    required this.description,
    this.skills = const [],
    this.score = 0.0,
  });
}
