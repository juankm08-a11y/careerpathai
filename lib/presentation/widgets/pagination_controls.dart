import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PaginationControls extends StatelessWidget {
  final int page;
  final VoidCallback onNext;
  final VoidCallback onPrev;
  const PaginationControls({
    super.key,
    required this.page,
    required this.onNext,
    required this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: onPrev, icon: const Icon(Icons.chevron_left)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text('Page $page'),
        ),
      ],
    );
  }
}
