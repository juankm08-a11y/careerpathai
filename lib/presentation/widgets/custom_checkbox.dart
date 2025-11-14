import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;
  final Color? activeColor;

  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: onChanged,
      title: Text(label),
      activeColor: activeColor ?? Theme.of(context).colorScheme.primary,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
