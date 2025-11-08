import 'package:careerpathai/core/constants/app_constants.dart';
import 'package:careerpathai/presentation/controllers/app_controller.dart';
import 'package:careerpathai/presentation/widgets/custom_icon_button.dart';
import 'package:careerpathai/presentation/widgets/custom_switch.dart';
import 'package:careerpathai/presentation/widgets/settings_title.dart';
import 'package:careerpathai/presentation/widgets/stats_box.dart';
import 'package:careerpathai/presentation/widgets/tag_list.dart';
import 'package:careerpathai/presentation/widgets/ucc_footer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    final appController = Get.find<AppController>();

    return Scaffold(
      appBar: AppBar(title: Text(AppTexts.profileTitle.tr)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => CustomSwitch(
                  value: appController.isDark.value,
                  onChanged: (val) => appController.toogleTheme(),
                  label: 'Dark Mode',
                ),
              ),

              CircleAvatar(radius: 45, child: Icon(Icons.person, size: 45)),
              const SizedBox(height: 16),
              Text(
                user?.email ?? '---',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
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

              SettingsTitle(
                title: 'User Preferences',
                subtitle: 'Manage your profile and notifications',
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                onTap: () => Get.snackbar(
                  'Info',
                  'Open user preferences',
                  snackPosition: SnackPosition.BOTTOM,
                ),
              ),

              const SizedBox(height: 20),

              const TagList(tags: ['Flutter', 'Dart', 'Firebase']),
              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    icon: Icons.edit,
                    tooltip: 'Edit Profile',
                    onPressed: () => Get.snackbar(
                      'Edit',
                      'Edit profile clicked',
                      snackPosition: SnackPosition.BOTTOM,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              CustomIconButton(
                icon: Icons.settings,
                tooltip: 'Settings',
                onPressed: () => Get.snackbar(
                  'Settings',
                  'Open settings clicked',
                  snackPosition: SnackPosition.BOTTOM,
                ),
              ),
              const SizedBox(height: 12),

              ElevatedButton(onPressed: logout, child: Text('logout'.tr)),
              const UccFooter(
                text: '© 2025 Universidad Cooperativa de Colombia',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
