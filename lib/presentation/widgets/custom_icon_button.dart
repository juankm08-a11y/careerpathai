import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      color: AppColors.primary,
    );
  }
}
