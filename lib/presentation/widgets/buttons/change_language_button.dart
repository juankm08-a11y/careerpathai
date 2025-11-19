import 'package:careerpathai/presentation/controllers/supabase_controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeLanguageButton extends StatelessWidget {
  const ChangeLanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appCtrl = Get.find<AppController>();

    return Row(
      children: [
        IconButton(
            onPressed: appCtrl.changeLanguage, icon: const Icon(Icons.language))
      ],
    );
  }
}
