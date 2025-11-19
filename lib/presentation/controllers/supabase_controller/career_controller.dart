import 'package:careerpathai/data/repositories/career_repository_impl.dart';
import 'package:careerpathai/domain/entities/career_entity.dart';
import 'package:careerpathai/domain/repositories/career_repository.dart';
import 'package:careerpathai/presentation/controllers/gemini_controller.dart';
import 'package:get/get.dart';

class CareerController extends GetxController {
  final CareerRepository _repo;

  CareerController({CareerRepository? repository})
      : _repo = repository ?? CareerRepositoryImpl();

  final RxList<CareerEntity> careers = <CareerEntity>[].obs;
  final RxBool loading = false.obs;

  final RxString aiRecommendations = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllCareers();
  }

  Future<void> loadAllCareers() async {
    loading.value = true;
    final list = await _repo.getAllCareers();
    careers.assignAll(list);
    loading.value = false;
  }

  Future<void> getRecommendations(Map<String, dynamic> profile) async {
    loading.value = true;

    try {
      final rawList = await GeminiController().generateRecommendations(profile);

      final entityList = rawList.map((item) {
        return CareerEntity(
          id: item['id'] ?? '',
          title: item['title'] ?? '',
          description: item['description'] ?? '',
          score:
              (item['score'] != null) ? (item['score'] as num).toDouble() : 0.0,
          skills: (item['skills'] is List)
              ? List<String>.from(item['skills'])
              : <String>[],
          skillsMatch: (item['skills_match'] != null)
              ? (item['skills_match'] as num).toDouble()
              : null,
          marketDemand: item['market_demand'] ?? 'Unknown',
          route:
              (item['route'] is List) ? List<String>.from(item['route']) : null,
          tags: (item['tags'] is List) ? List<String>.from(item['tags']) : null,
          workEnvironment: item['work_environment']?.toString(),
          employability: (item['employability'] != null)
              ? (item['employability'] as num).toDouble()
              : null,
          avgSalary: (item['avg_salary'] != null)
              ? (item['avg_salary'] as num).toDouble()
              : null,
          jobOpportunities: item['job_opportunities'] ?? 'Unknown',
          trend: item['trend']?.toString(),
          purpose: (item['purpose'] is Map)
              ? Map<String, dynamic>.from(item['purpose'])
              : null,
        );
      }).toList();
      careers.value = entityList;
      print("Loaded ${entityList.length} AI recommendations");
    } catch (e) {
      print("Error loading recommendations: $e");
    } finally {
      loading.value = false;
    }
  }

  void setAIRecommendations(String text) {
    aiRecommendations.value = text;
  }
}
