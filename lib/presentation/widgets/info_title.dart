import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class InfoTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData? icon;
  const InfoTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon, color: AppColors.primary) : null,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
    );
  }
}
