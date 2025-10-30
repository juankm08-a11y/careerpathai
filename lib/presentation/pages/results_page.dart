import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/controllers/career_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/career_entity.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final CareerController _ctrl = Get.find<CareerController>();
  bool _sortByScoreDesc = true;

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
    if (score >= 8) return 'Muy alta afinidad';
    if (score >= 5) return 'Media afinida';
    return 'Baja afinidad';
  }

  void _toggleFavorite(String id) {
    setState(() {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
        Get.snackbar(
          'Favorito',
          'Eliminado de favoritos',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        _favorites.add(id);
        Get.snackbar(
          'Favorito',
          'Añadido a favoritos',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de Carrera'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            tooltip: _sortByScoreDesc
                ? 'Ordenar por puntuación ascendente'
                : 'Ordenar por puntuación descendente',
            onPressed: () {
              setState(() {
                _sortByScoreDesc = !_sortByScoreDesc;
              });
            },
            icon: Icon(_sortByScoreDesc ? Icons.sort_by_alpha : Icons.sort),
          ),
        ],
      ),
      body: Obx(() {
        if (_ctrl.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final list = _sortedList;
        if (list.isEmpty) {
          return const Center(
            child: Text('No hay recomendaciones disponibles.'),
          );
        }

        return RefreshIndicator(
          onRefresh: _ctrl.loadAllCareers,
          child: ListView(
            padding: const EdgeInsets.all(14),
            children: [
              const Text(
                'Según tus respuestas y afinidades, estas son las carreras que mejor se ajustan a tu perfil:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              for (final c in list)
                Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    title: Text(c.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.description),
                        const SizedBox(height: 6),
                        Text(
                          'Nivel de afinidad: ${getLevel(c.score)} (Puntuación)',
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
              ElevatedButton.icon(
                onPressed: () {
                  Get.offAllNamed('/test');
                },
                icon: const Icon(Icons.restart_alt),
                label: const Text('Retake the test'),
              ),
            ],
          ),
        );
      }),
    );
  }
}
