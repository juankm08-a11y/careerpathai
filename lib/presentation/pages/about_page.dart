import 'package:careerpathai/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('about'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppTexts.aboutTitle.tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('about_description'.tr, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
