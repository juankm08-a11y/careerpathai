import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class UccFooter extends StatelessWidget {
  final String text;
  const UccFooter({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
