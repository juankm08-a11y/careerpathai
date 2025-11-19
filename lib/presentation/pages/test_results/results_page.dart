import 'package:careerpathai/domain/entities/career_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/supabase_controller/career_controller.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final CareerController _ctrl = Get.find<CareerController>();
  final bool _sortByScoreDesc = true;

  final Set<String> _favorites = {};

  @override
  void initState() {
    super.initState();
    if (_ctrl.careers.isEmpty) {
      _ctrl.loadAllCareers();
    }
  }

  List<CareerEntity> get _sortedList {
    final copy = List<CareerEntity>.from(_ctrl.careers);
    copy.sort(
      (a, b) => _sortByScoreDesc
          ? b.score.compareTo(a.score)
          : a.score.compareTo(b.score),
    );
    return copy;
  }

  String getLevel(double score) {
    if (score >= 8) return 'high_affinity'.tr;
    if (score >= 5) return 'medium_affinity'.tr;
    return 'low_affinity'.tr;
  }

  void _toggleFavorite(String id) {
    setState(() {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
        Get.snackbar(
          'favorite_removed'.tr,
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        _favorites.add(id);
        Get.snackbar(
          'favorite_added'.tr,
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('results'.tr),
      ),
      body: Obx(() {
        if (_ctrl.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final list = _sortedList;
        if (list.isEmpty) {
          return Center(child: Text('no_recommendations'.tr));
        }

        return RefreshIndicator(
          onRefresh: _ctrl.loadAllCareers,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'results_intro'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),

              // List of cards
              for (final c in list)
                Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(c.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.description),
                        const SizedBox(height: 6),
                        Text(
                          '${'affinity_level'.tr}: ${getLevel(c.score)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: c.score >= 8
                                ? Colors.green
                                : (c.score >= 5 ? Colors.orange : Colors.red),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        _favorites.contains(c.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _favorites.contains(c.id)
                            ? Colors.red
                            : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorite(c.id),
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              Center(
                child: ElevatedButton.icon(
                  onPressed: () => Get.offAllNamed('/test'),
                  icon: const Icon(Icons.restart_alt),
                  label: Text('start_test'.tr),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
