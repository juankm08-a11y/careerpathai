import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FilterChipGroup extends StatelessWidget {
  final List<String> items;
  final Set<String> selected;
  final ValueChanged<String> onToogle;
  const FilterChipGroup({
    super.key,
    required this.items,
    required this.selected,
    required this.onToogle,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: items.map((item) {
        final sel = selected.contains(item);
        return ChoiceChip(
          selected: sel,
          label: Text(item),
          onSelected: (_) => onToogle(item),
          selectedColor: AppColors.primary,
        );
      }).toList(),
    );
  }
}
