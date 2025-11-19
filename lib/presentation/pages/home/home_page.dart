import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:careerpathai/core/constants/app_routes.dart';
import 'package:careerpathai/core/constants/app_texts.dart';
import 'package:careerpathai/presentation/widgets/buttons/app_button.dart';
import 'package:careerpathai/presentation/widgets/filter_chip_group/filter_chip_group.dart';
import 'package:careerpathai/presentation/widgets/header/app_header.dart';
import 'package:careerpathai/presentation/widgets/cards/custom_card.dart';
import 'package:careerpathai/presentation/widgets/empty_state/empty_state.dart';
import 'package:careerpathai/presentation/widgets/gradient_background/gradient_background.dart';
import 'package:careerpathai/presentation/widgets/title/info_title.dart';
import 'package:careerpathai/presentation/widgets/loading_overlay/loading_overlay.dart';
import 'package:careerpathai/presentation/widgets/profile_avatar/profile_avatar.dart';
import 'package:careerpathai/presentation/widgets/progress/result_progress.dart';
import 'package:careerpathai/presentation/widgets/title/section_title.dart';
import 'package:careerpathai/presentation/widgets/tag/skill_tag.dart';
import 'package:careerpathai/presentation/widgets/footer/ucc_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = false.obs;
    final hasProgress = true.obs;

    final List<String> careers = [
      "Software Engineering",
      "Data Science",
      "Cybersecurity",
      "Graphic Design",
      "Marketing",
    ];

    final RxSet<String> selectedCareers = <String>{}.obs;

    return Obx(
      () => LoadingOverlay(
        isLoading: isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary.withValues(alpha: 0.8),
            title: Text(HomeTexts.title.tr),
            actions: [
              IconButton(
                onPressed: () => Get.toNamed(AppRoutes.profile),
                icon: const Icon(Icons.person),
                tooltip: HomeTexts.profileTitle.tr,
              ),
              IconButton(
                onPressed: () => Get.toNamed(AppRoutes.about),
                icon: const Icon(Icons.info_outline),
                tooltip: HomeTexts.aboutTitle.tr,
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
                    InfoTitle(
                        title: HomeTexts.welcomeBack.tr,
                        subtitle: HomeTexts.emptySubtitle),
                    const SizedBox(height: 12),
                    SectionTitle(title: HomeTexts.quickActions),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: [
                        AppButton(
                          text: HomeTexts.startText.tr,
                          onPressed: () => Get.toNamed(AppRoutes.test),
                        ),
                        AppButton(
                          text: HomeTexts.results.tr,
                          onPressed: () => Get.toNamed(AppRoutes.results),
                        ),
                        AppButton(
                          text: HomeTexts.register.tr,
                          onPressed: () => Get.toNamed(AppRoutes.register),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SectionTitle(title: HomeTexts.progress.tr),
                    const ResultProgress(value: 8, label: "Speed"),
                    const SizedBox(height: 20),
                    SectionTitle(title: HomeTexts.yourSkills.tr),
                    const SizedBox(height: 20),
                    SectionTitle(title: HomeTexts.bestCareers.tr),
                    Obx(() => FilterChipGroup(
                        items: careers,
                        selected: selectedCareers,
                        onToogle: (item) {
                          if (selectedCareers.contains(item)) {
                            selectedCareers.remove(item);
                          } else {
                            selectedCareers.add(item);
                          }
                        })),
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
