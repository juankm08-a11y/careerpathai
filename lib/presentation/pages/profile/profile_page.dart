import 'package:careerpathai/core/constants/app_texts.dart';
import 'package:careerpathai/presentation/controllers/supabase_controller/app_controller.dart';
import 'package:careerpathai/presentation/widgets/buttons/custom_icon_button.dart';
import 'package:careerpathai/presentation/widgets/title/settings_title.dart';
import 'package:careerpathai/presentation/widgets/stats_boc/stats_box.dart';
import 'package:careerpathai/presentation/widgets/tag/tag_list.dart';
import 'package:careerpathai/presentation/widgets/footer/ucc_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final appController = Get.find<AppController>();

    return Scaffold(
      appBar: AppBar(title: Text(ProfileTexts.title.tr)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Text(
              user?.email ?? '---',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                StatsBox(title: 'Projects', value: '12'),
                SizedBox(width: 16),
                StatsBox(title: 'Skills', value: '8'),
                SizedBox(width: 16),
                StatsBox(title: 'Badges', value: '5'),
              ],
            ),
            const SizedBox(height: 25),
            const TagList(tags: ['Flutter', 'Dart', 'Firebase']),
            const SizedBox(height: 25),
            SettingsTitle(
              title: ProfileTexts.userPreferences.tr,
              subtitle: ProfileTexts.subtitle.tr,
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () => Get.snackbar(
                'Info',
                'Open user preferences',
                snackPosition: SnackPosition.BOTTOM,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () => appController.pickProfilePhoto(),
              child: const CircleAvatar(
                radius: 45,
                child: Icon(Icons.person, size: 45),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconButton(
                  icon: Icons.edit,
                  tooltip: ProfileTexts.editProfile.tr,
                  onPressed: () => Get.snackbar('Edit', 'Edit profile clicked'),
                ),
                const SizedBox(width: 12),
                CustomIconButton(
                  icon: Icons.settings,
                  tooltip: ProfileTexts.settings.tr,
                  onPressed: () => appController.showConfigurations(context),
                ),
              ],
            ),
            const SizedBox(height: 25),
            const TagList(tags: ['Flutter', 'Dart', 'Firebase', 'Python']),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: appController.logout,
              child: Text(ProfileTexts.logout.tr),
            ),
            const SizedBox(height: 20),
            const UccFooter(
              text: '© 2025 Universidad Cooperativa de Colombia',
            ),
          ],
        ),
      ),
    );
  }
}
