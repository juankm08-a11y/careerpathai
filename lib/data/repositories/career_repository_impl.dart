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
            (0.3 * (skillMatch / (c.skills.isEmpty ? 1 : c.skills.length))) +
            (0.15 * personalityMatch) +
            (0.15 * subjectMatch);

        return CareerModel(
          id: c.id,
          title: c.title,
          description: c.description,
          skills: c.skills,
          jobOpportunities: c.jobOpportunities,
          score: double.parse(score.toStringAsFixed(3)),
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
        title: 'Ingeniería de Software',
        description:
            'Desarrollo de sistemas informáticos a través de diferentes técnicas de análisis, diseño, programación, pruebas y mantenimiento. Uso de lenguajes de programación y herramientas de desarrollo de software, diseño y implementación de sistemas de software, es la carrera del futuro papa!',
        skills: [
          'Solución de Problemas Tecnológicos',
          'Programación y Desarrollo Web',
          'Bases de datos',
          'Análisis de sistemas',
          'Mantenimiento y actualización de software',
          'Inteligencia artificial',
          'La nube',
          'Análisis de Datos',
          'Desarrollo Móvil',
          'Ciberseguridad y Hacking ético',
          'Programación Orientada a Objetos',
        ],
        score: 1.25,
      ),
      CareerModel(
        id: '2',
        title: 'Ingeniería Industrial',
        description:
            'Diseño, implementación y optimización de procesos productivos, operaciones técnicas y organizaciones que permiten la agregación de valor, calidad y eficiencia a las empresas.',
        skills: [
          'gestión de procesos',
          'logística',
          'estadística',
          'producción',
        ],
        score: 0.95,
      ),
      CareerModel(
        id: '3',
        title: 'Medicina',
        description:
            'Disciplina cíentifica y práctica centrada en el estudio, diagnóstico, tratamiento y prevención de enfermedades y lesiones humanas.',
        skills: [
          'biología',
          'anatomía',
          'ética médica',
          'investigación científica',
        ],
        score: 0.77,
      ),
      CareerModel(
        id: '4',
        title: 'Enfermería',
        description:
            'Atención integral al paciente, promoción de la salud y apoyo en procedimientos médicos.',
        skills: [
          'cuidado del paciente',
          'empatía',
          'primeros auxilios',
          'trabajo en equipo',
        ],
        score: 0.74,
      ),
      CareerModel(
        id: '5',
        title: 'Odontología',
        description:
            'Ciencia de la salud, que estudia el diagnóstico, pronostico, tratamiento y prevención de las enfermedades dels sitema estomatognático.',
        skills: [
          'anatomía dental',
          'salud oral',
          'habilidad manual',
          'bioseguridad',
        ],
        score: 0.78,
      ),
      CareerModel(
        id: '6',
        title: 'Derecho',
        description:
            'Estudio y aplicación jurídicas para la defensa de la justicia,la equidad y los derechos humanos.',
        skills: [
          'argumentación',
          'redacción jurídica',
          'análisis crítico',
          'ética profesional',
        ],
        score: 0.8,
      ),
    ];
  }
}
