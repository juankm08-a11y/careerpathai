import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/career_entity.dart';
import '../../domain/repositories/career_repository.dart';
import '../models/career_model.dart';

class CareerRepositoryImpl implements CareerRepository {
  final SupabaseClient _client;

  CareerRepositoryImpl({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  @override
  Future<List<CareerEntity>> getAllCareers() async {
    try {
      final res = await _client.from('career').select().order('title');

      if (res.isEmpty) {
        return _fallbackCareers();
      }

      return List<Map<String, dynamic>>.from(
        res,
      ).map((m) => CareerModel.fromMap(m)).toList();
    } catch (e) {
      return _fallbackCareers();
    }
  }

  @override
  Future<CareerEntity?> findById(String id) async {
    try {
      final res = await _client
          .from('career')
          .select()
          .eq('id', id)
          .maybeSingle();
      if (res == null) return null;
      return CareerModel.fromMap(res);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<CareerEntity>> recommendForProfile(
    Map<String, dynamic> profile,
  ) async {
    try {
      final all = await getAllCareers();
      final interests = (profile['interests'] as List? ?? []).cast<String>();
      final skills = (profile['skills'] as List? ?? []).cast<String>();
      final personality = (profile['personality'] ?? '')
          .toString()
          .toLowerCase();
      final favoriteSubjects = (profile['favoriteSubjects'] ?? '')
          .toString()
          .toLowerCase();

      List<CareerEntity> scored = all.map((c) {
        final title = c.title.toLowerCase();
        final description = c.description.toLowerCase();

        final matchInterests = interests
            .where(
              (i) =>
                  title.contains(i.toLowerCase()) ||
                  description.contains(i.toLowerCase()),
            )
            .length;

        final skillMatchCount = c.skills
            .where(
              (s) =>
                  skills.map((e) => e.toLowerCase()).contains(s.toLowerCase()),
            )
            .length
            .toDouble();

        final personalityMatch =
            personality.isNotEmpty && description.contains(personality)
            ? 1.0
            : 0.0;

        final subjectMatch =
            favoriteSubjects.isNotEmpty &&
                description.contains(favoriteSubjects)
            ? 1.0
            : 0.0;

        final double normalizedSkillMatch = c.skills.isEmpty
            ? 0.0
            : (skillMatchCount / c.skills.length);

        final score =
            (0.4 * matchInterests) +
            (0.3 * normalizedSkillMatch) +
            (0.15 * personalityMatch) +
            (0.15 * subjectMatch);

        return CareerModel(
          id: c.id,
          title: c.title,
          description: c.description,
          skills: c.skills,
          jobOpportunities: c.jobOpportunities,
          score: double.parse(score.toStringAsFixed(3)),
          skillsMatch: (c is CareerModel) ? c.skillsMatch : null,
          marketDemand: (c is CareerModel) ? c.marketDemand : null,
          route: (c is CareerModel) ? c.route : null,
          tags: (c is CareerModel) ? c.tags : null,
          workEnvironment: (c is CareerModel) ? c.workEnvironment : null,
          employability: (c is CareerModel) ? c.employability : null,
          avgSalary: (c is CareerModel) ? c.avgSalary : null,
          trend: (c is CareerModel) ? c.trend : null,
          purpose: (c is CareerModel) ? c.purpose : null,
        );
      }).toList();

      scored.sort((a, b) => b.score.compareTo(a.score));
      return scored;
    } catch (e) {
      return _fallbackCareers();
    }
  }

  List<CareerEntity> _fallbackCareers() {
    return [
      CareerModel(
        id: '1',
        title: 'Software Engineering',
        description:
            'Development of software system throught techniques such as analysis, design, programming, testing, and maintenance using multiple programming language and development tools.',
        jobOpportunities:
            'High demand in software companies, startups, and tech  ecosystems',
        skills: [
          'Tecnological problem solving',
          'Web and software development',
          'Database',
          'Systems analysis',
          'Artificial inteligenc'
              'Cloud Computing',
        ],
        score: 1.25,
        marketDemand: 'High',
        route: [
          'Mathematics',
          'Programming',
          'Algorithms',
          'Web',
          'Mobile',
          'Cloud',
        ],
        tags: ['tech', 'programming', 'ai'],
      ),
      CareerModel(
        id: '2',
        title: 'Industrial Engineering',
        description:
            'Design, implementation and optimization of production processes and technical operational to improve organizational efficiency and quality',
        jobOpportunities:
            'Manufacturing, logistics, consulting and operations management',
        skills: ['process management', 'logistics', 'statistics', 'production'],
        score: 0.95,
        marketDemand: 'medium',
        route: ['Mathematics', 'Statics', 'Operations', 'Lean management'],
        tags: ['management', 'operations'],
      ),
      CareerModel(
        id: '3',
        title: 'Medicine',
        description:
            'Scientific and clinical discipline focused on the study, diagnosis, treatment, and prevention of human diseases.',
        jobOpportunities:
            'Hospitals, clinics, research, and public health institutions',
        skills: ['biology', 'anatomy', 'medical ethics', 'scientific research'],
        score: 0.77,
        marketDemand: 'High',
        route: ['Biology', 'Chemistry', 'Clinical training'],
        tags: ['health', 'science'],
      ),
      CareerModel(
        id: '4',
        title: 'Nursing',
        description:
            'Comprehensive patient care, health promotion, and support in medical procedures.',
        jobOpportunities: 'Hospitals, community health centers, and clinics',
        skills: ['patient care', 'empathy', 'first aid', 'teamwork'],
        score: 0.74,
        marketDemand: 'High',
        route: ['Health sciences', 'Clinical practice'],
        tags: ['health', 'care'],
      ),
      CareerModel(
        id: '5',
        title: 'Dentistry',
        description:
            'Health science focused on diagnosis, treatment, and prevention of oral diseases.',
        jobOpportunities:
            'Private practices, dental clinics, and public health institutions',
        skills: [
          'dental anatomy',
          'oral health',
          'manual skills',
          'biosecurity',
        ],
        score: 0.78,
        marketDemand: 'Medium',
        route: ['Biology', 'Clinical practice', 'Manual skills'],
        tags: ['health', 'manual'],
      ),
      CareerModel(
        id: '6',
        title: 'Law',
        description:
            'Study and application of legal systems to defend justice, equity, and human rights.',
        jobOpportunities: 'Law firms, corporate law, public sector, and NGOs',
        skills: [
          'argumentation',
          'legal writing',
          'critical thinking',
          'professional ethics',
        ],
        score: 0.8,
        marketDemand: 'Medium',
        route: ['Critical thinking', 'Legal studies', 'Internships'],
        tags: ['law', 'public'],
      ),
    ];
  }
}
