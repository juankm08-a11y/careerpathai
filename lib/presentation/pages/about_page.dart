import 'package:careerpathai/core/constants/app_routes.dart';
import 'package:careerpathai/core/constants/app_texts.dart';
import 'package:careerpathai/presentation/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    final appCtrl = Get.find<AppController>();

    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.aboutTitle.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.language),
              onPressed: () => appController.changeLanguage(),
            ),
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed: () => appCtrl.toogleTheme(),
              tooltip: AppTexts.theme.tr,
            ),
            Text(
              AppTexts.aboutTitle.tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              AppDescriptions.aboutDescription.tr,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
