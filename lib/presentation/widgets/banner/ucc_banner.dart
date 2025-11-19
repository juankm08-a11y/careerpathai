import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UccBanner extends StatelessWidget {
  final String text;
  const UccBanner({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text.tr,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
