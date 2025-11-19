import 'package:careerpathai/domain/entities/career_entity.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CareerCard extends StatelessWidget {
  final CareerEntity career;
  final VoidCallback? onTap;

  const CareerCard({super.key, required this.career, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primary,
                child: Text(
                  career.title[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      career.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      career.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.insights,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Score: ${career.score.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
