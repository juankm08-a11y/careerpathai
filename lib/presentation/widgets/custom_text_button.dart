import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? textColor;

  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? AppColors.primary,
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor ?? AppColors.secondary),
      ),
    );
  }
}
