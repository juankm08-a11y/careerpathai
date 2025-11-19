import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:careerpathai/presentation/controllers/supabase_controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const GradientBackground({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();

    return Obx(() {
      final isDark = appController.isDark.value;

      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black, Colors.grey.shade900]
                : [AppColors.primary.withValues(alpha: 0.2), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
        ),
        padding: padding ?? const EdgeInsets.all(20),
        child: SafeArea(child: child),
      );
    });
  }
}
