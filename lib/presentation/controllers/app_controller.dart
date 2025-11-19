import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppController extends GetxController {
  RxBool isDark = false.obs;

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
    Get.offAllNamed('/login');
  }

  void toogleTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  void changeLanguage() {
    final systemLocale = Get.deviceLocale?.languageCode ?? 'en';

    if (systemLocale == 'es') {
      Get.updateLocale(const Locale('es', 'CO'));
    } else {
      Get.updateLocale(const Locale('en', 'US'));
    }
  }

  void showConfigurations(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Configurations",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                    onTap: () => logout(),
                  )
                ],
              ),
            ));
  }

  void pickProfilePhoto() {
    Get.snackbar("Photo", "Open image picker here",
        snackPosition: SnackPosition.BOTTOM);
  }
}
