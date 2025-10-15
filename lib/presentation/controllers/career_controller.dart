import 'package:get/get.dart';
import '../../domain/entities/career_entity.dart';
import '../../domain/repositories/career_repository.dart';
import '../../data/repositories/career_repository_impl.dart';

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
    final recs = await _repo.recommendForProfile(profile);
    careers.assignAll(recs);
    loading.value = false;
  }

  void setAIRecommendations(String text) {
    aiRecommendations.value = text;
  }
}
