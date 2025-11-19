import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:careerpathai/core/constants/app_routes.dart';
import 'package:careerpathai/core/constants/app_texts.dart';
import 'package:careerpathai/presentation/controllers/app_controller.dart';
import 'package:careerpathai/presentation/widgets/app_button.dart';
import 'package:careerpathai/presentation/widgets/app_header.dart';
import 'package:careerpathai/presentation/widgets/custom_card.dart';
import 'package:careerpathai/presentation/widgets/empty_state.dart';
import 'package:careerpathai/presentation/widgets/gradient_background.dart';
import 'package:careerpathai/presentation/widgets/info_title.dart';
import 'package:careerpathai/presentation/widgets/loading_overlay.dart';
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

    final isLoading = false.obs;
    final hasProgress = true.obs;

    return Obx(
      () => LoadingOverlay(
        isLoading: isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary.withValues(alpha: 0.8),
            title: Text(AppTexts.homeTitle),
            actions: [
              IconButton(
                onPressed: () => Get.toNamed(AppRoutes.profile),
                icon: const Icon(Icons.person),
                tooltip: AppTexts.profileTitle.tr,
              ),
              IconButton(
                onPressed: () => Get.toNamed(AppRoutes.about),
                icon: const Icon(Icons.info_outline),
                tooltip: AppTexts.aboutTitle.tr,
              ),
              IconButton(
                icon: const Icon(Icons.language),
                onPressed: () => controller.changeLanguage(),
              ),
            ],
          ),
          body: GradientBackground(
            child: SingleChildScrollView(
              child: Obx(() {
                if (!hasProgress.value) {
                  return const EmptyState(
                    title: 'No data available',
                    subtitle:
                        "Start your first to see your progress and skills here.",
                  );
                }

                return Column(
                  children: [
                    const AppHeader(title: 'Home', icon: Icons.home_outlined),
                    const ProfileAvatar(initials: 'J'),
                    const SizedBox(height: 16),
                    InfoTitle(title: 'Welcome Back', subtitle: 'Juan'),
                    const SizedBox(height: 12),
                    const SectionTitle(title: 'Quick Actions'),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        AppButton(
                          text: AppTexts.startTest.tr,
                          onPressed: () => Get.toNamed(AppRoutes.test),
                        ),
                        AppButton(
                          text: AppTexts.results,
                          onPressed: () => Get.toNamed(AppRoutes.results),
                        ),
                        AppButton(
                          text: AppTexts.register,
                          onPressed: () => Get.toNamed(AppRoutes.register),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const SectionTitle(title: "Progress"),
                    const ResultProgress(value: 8, label: "Speed"),
                    const SizedBox(height: 20),
                    const SectionTitle(title: "Your skills"),
                    Wrap(
                      spacing: 8,
                      children: const [
                        SkillTag(text: "Flutter"),
                        SkillTag(text: "Dart"),
                        SkillTag(text: "Firebase"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const CustomCard(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "You can customize this to show news, highlights, or app features",
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const UccFooter(
                      text: '© 2025 Universidad Cooperativa de Colombia',
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
