import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:careerpathai/core/constants/app_constants.dart';
import 'package:careerpathai/presentation/controllers/app_controller.dart';
import 'package:careerpathai/presentation/widgets/app_button.dart';
import 'package:careerpathai/presentation/widgets/custom_card.dart';
import 'package:careerpathai/presentation/widgets/info_title.dart';
import 'package:careerpathai/presentation/widgets/profile_avatar.dart';
import 'package:careerpathai/presentation/widgets/result_progress.dart';
import 'package:careerpathai/presentation/widgets/section_title.dart';
import 'package:careerpathai/presentation/widgets/skill_tag.dart';
import 'package:careerpathai/presentation/widgets/ucc_footer.dart';
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
          IconButton(
            onPressed: () => Get.toNamed(AppConstants.routeProfile),
            icon: const Icon(Icons.person_outline),
          ),
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: controller.isDark.value
                ? [Colors.black, Colors.grey.shade900]
                : [AppColors.primary.withValues(alpha: 0.2), Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const ProfileAvatar(initials: 'A'),
                const SizedBox(height: 16),
                InfoTitle(title: 'Welcome Back!', subtitle: 'Juan'),
                const SizedBox(height: 12),
                const SectionTitle(title: 'Quick Actions'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    AppButton(
                      text: AppTexts.test.tr,
                      onPressed: () => Get.toNamed(AppRoutes.startTest),
                    ),
                    AppButton(
                      text: 'Results'.tr,
                      onPressed: () => Get.toNamed(AppRoutes.results),
                    ),
                    AppButton(
                      text: "register".tr,
                      onPressed: () => Get.toNamed(AppRoutes.register),
                    ),
                    const SizedBox(height: 20),
                    const SectionTitle(title: "Progress"),
                    const ResultProgress(value: 8, label: "speed"),
                    const SizedBox(height: 20),
                    const SectionTitle(title: "Your Skills"),
                    Wrap(
                      spacing: 8,
                      children: const [
                        SkillTag(text: 'Flutter'),
                        SkillTag(text: 'Dart'),
                        SkillTag(text: 'Firebase'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const CustomCard(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Tou can customize this to show news, highlights, or app futures.",
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const UccFooter(text: 'Ucc Footer'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
