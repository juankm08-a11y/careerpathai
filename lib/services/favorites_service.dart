import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FavoritesService extends GetxService {
  static FavoritesService get instance => Get.find<FavoritesService>();

  late Box _box;
  final RxSet<String> _ids = <String>{}.obs;

  Set<String> get favoritesIds => _ids;

  Future<FavoritesService> init() async {
    _box = await Hive.openBox('favorites');
    final List stored = _box.get('ids', defaultValue: <String>[]) as List;
    _ids.addAll(stored.cast<String>());
    return this;
  }

  Future<void> addFavorite(String id) async {
    _ids.add(id);
    await _box.put('ids', _ids.toList());
  }

  Future<void> removeFavorite(String id) async {
    _ids.remove(id);
    await _box.put('ids', _ids.toList());
  }
}
