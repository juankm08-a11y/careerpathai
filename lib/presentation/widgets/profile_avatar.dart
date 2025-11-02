import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final String initials;
  const ProfileAvatar({super.key, this.imageUrl, required this.initials});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32,
      backgroundColor: AppColors.primary,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child: imageUrl == null
          ? Text(
              initials,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            )
          : null,
    );
  }
}
