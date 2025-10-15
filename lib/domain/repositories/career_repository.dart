import '../entities/career_entity.dart';

abstract class CareerRepository {
  Future<List<CareerEntity>> getAllCareers();
  Future<List<CareerEntity>> recommendForProfile(Map<String, dynamic> profile);
  Future<CareerEntity?> findById(String id);
}
