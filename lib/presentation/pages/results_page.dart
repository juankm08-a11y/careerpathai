import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../presentation/controllers/career_controller.dart';
import '../widgets/career_card.dart';
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

  void _showDetail(CareerEntity career) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          initialChildSize: 0.58,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (_, controller) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: ListView(
              controller: controller,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        career.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _favorites.contains(career.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _favorites.contains(career.id)
                            ? Colors.red
                            : null,
                      ),
                      onPressed: () => _toggleFavorite(career.id),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(career.description, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: career.skills.map((s) {
                    return Chip(label: Text(s));
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text:
                                '${career.title}\n\n${career.description}\n\nScore: ${career.score.toStringAsFixed(2)}',
                          ),
                        );
                        Get.snackbar(
                          'Copiado',
                          'Detalles copiados al portapapeles',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('Copiar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      onPressed: () {
                        Get.back();
                        Get.snackbar(
                          'Navegar',
                          'Funcionalidad de cursos pendiente',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      icon: const Icon(Icons.school_outlined),
                      label: const Text('Ver cursos'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Afinidad: ${career.score.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _refresh() async {
    await _ctrl.loadAllCareers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            tooltip: _sortByScoreDesc ? 'Ordenar asc' : 'Ordenar desc',
            onPressed: () {
              setState(() {
                _sortByScoreDesc = !_sortByScoreDesc;
              });
            },
            icon: Icon(_sortByScoreDesc ? Icons.sort_by_alpha : Icons.sort),
          ),
          IconButton(
            tooltip: 'Ver favoritos',
            icon: const Icon(Icons.favorite),
            onPressed: () {
              final favs = _ctrl.careers
                  .where((c) => _favorites.contains(c.id))
                  .toList();
              if (favs.isEmpty) {
                Get.snackbar(
                  'Favoritos',
                  'No tienes favoritos',
                  snackPosition: SnackPosition.BOTTOM,
                );
                return;
              }
              showModalBottomSheet(
                context: context,
                builder: (_) => ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (_, i) {
                    final c = favs[i];
                    return ListTile(
                      title: Text(c.title),
                      subtitle: Text('Score: ${c.score.toStringAsFixed(2)}'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _showDetail(c);
                      },
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                  itemCount: favs.length,
                ),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (_ctrl.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final list = _sortedList;
        if (list.isEmpty) {
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                const Icon(Icons.search_off, size: 80, color: Colors.grey),
                const SizedBox(height: 12),
                const Center(
                  child: Text(
                    'No hay recomendaciones. Haz el test para obtenerlas.',
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: _refresh,
          child: ListView.separated(
            padding: const EdgeInsets.all(14),
            itemCount: list.length,
            itemBuilder: (_, i) {
              final c = list[i];
              return GestureDetector(
                onTap: () => _showDetail(c),
                child: CareerCard(career: c, onTap: () => _showDetail(c)),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
          ),
        );
      }),
    );
  }
}
