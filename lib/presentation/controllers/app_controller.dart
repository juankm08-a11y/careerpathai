import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxBool isDark = false.obs;

  void toogleTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.updateLocale(const Locale('en', 'US'));
                Get.back();
              },
              child: const Text('English'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Get.updateLocale(const Locale('es', 'CO'));
                Get.back();
              },
              child: const Text("Español"),
            ),
          ],
        ),
      ),
    );
  }
}
