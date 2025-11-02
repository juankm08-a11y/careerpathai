import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => Get.toNamed('/profile'),
            tooltip: 'profile'.tr,
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Get.toNamed('/about'),
            tooltip: 'about'.tr,
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.toNamed('/test'),
          child: Text('start_test'.tr),
        ),
      ),
    );
  }
}
