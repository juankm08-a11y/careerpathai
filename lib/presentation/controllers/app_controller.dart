import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxBool isDark = false.obs;

  void toogleTheme() {
    isDark.value = !isDark.value;
    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
  }

  void navigateByLanguage() {
    final systemLocale = Get.deviceLocale?.languageCode ?? 'en';

    if (systemLocale == 'es') {
      Get.updateLocale(const Locale('es', 'CO'));
    } else {
      Get.updateLocale(const Locale('en', 'US'));
    }
  }
}
