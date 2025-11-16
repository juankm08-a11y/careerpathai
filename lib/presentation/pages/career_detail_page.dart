import 'package:careerpathai/core/constants/app_routes.dart';
import 'package:careerpathai/core/constants/app_texts.dart';
import 'package:careerpathai/domain/entities/career_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CareerDetailPage extends StatelessWidget {
  const CareerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CareerEntity career = Get.arguments as CareerEntity;

    return Scaffold(
      appBar: AppBar(
        title: Text(career.title),
        actions: [
          Obx(() {
            final favs = FavoritesService.instante.favoritesIds;
            final isFav = favs.contains(career.id);
            return IconButton(
              onPressed: () async {
                if (isFav) {
                  await FavoritesService.instance.removeFavorite(career.id);
                } else {
                  await FavoritesService.instance.addFavorite(career.id);
                }
              },
              icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: career.id,
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.9),
                ),
                child: Center(
                  child: Text(
                    career.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(career.description),
            const SizedBox(height: 12),
            if (career.skills.isNotEmpty) ...[
              const Text(
                'Know your skills ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Market demand: ${career.marketDemand ?? 'Unknown'}'),
              const SizedBox(height: 12),

              if (career.route != null && career.route!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: career.route!
                      .map(
                        (r) => ListTile(
                          leading: const Icon(Icons.check),
                          title: Text((r)),
                        ),
                      )
                      .toList(),
                ),
            ],

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.careerComparePage, arguments: [career]);
              },
              child: Text(AppTexts.compare.tr),
            ),
          ],
        ),
      ),
    );
  }
}
