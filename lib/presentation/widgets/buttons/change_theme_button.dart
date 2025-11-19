import 'package:careerpathai/presentation/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeThemeButton extends StatelessWidget {
  const ChangeThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appCtrl = Get.find<AppController>();

    return Row(
      children: [
        IconButton(
            onPressed: appCtrl.toogleTheme,
            icon: const Icon(Icons.brightness_6),
            tooltip: 'Theme'),
      ],
    );
  }
}
