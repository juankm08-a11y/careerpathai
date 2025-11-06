import 'package:careerpathai/core/constants/app_constants.dart';
import 'package:careerpathai/presentation/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppController controller = Get.find<AppController>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.homeTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Get.toNamed(AppConstants.routeProfile),
            tooltip: AppConstants.profileTitle.tr,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Get.toNamed(AppConstants.routeAbout),
            tooltip: AppConstants.aboutTitle.tr,
          ),
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: 'Change Language',
            onPressed: () {
              Get.defaultDialog(
                title: 'Selected Language',
                content: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => controller.changeLanguage("en"),
                      child: const Text('English'),
                    ),
                    ElevatedButton(
                      onPressed: () => controller.changeLanguage("es"),
                      child: const Text("Español"),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.dark_mode_outlined),
            tooltip: 'toogle Theme',
            onPressed: controller.toogleTheme,
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.toNamed(AppConstants.routeTest),
          child: Text(AppConstants.startTest.tr),
        ),
      ),
    );
  }
}
