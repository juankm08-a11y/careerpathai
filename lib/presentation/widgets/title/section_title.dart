import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(width: 6, height: 24, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(
            title.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
