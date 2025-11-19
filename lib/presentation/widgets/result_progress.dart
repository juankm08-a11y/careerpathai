import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ResultProgress extends StatelessWidget {
  final double value;
  final String label;

  const ResultProgress({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        LinearProgressIndicator(
          value: value,
          color: AppColors.primary,
          backgroundColor: AppColors.primary.withValues(alpha: 0.15),
        ),
      ],
    );
  }
}
