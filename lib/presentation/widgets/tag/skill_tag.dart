import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class SkillTag extends StatelessWidget {
  final String text;
  const SkillTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Text(text, style: TextStyle(color: AppColors.primary)),
    );
  }
}
