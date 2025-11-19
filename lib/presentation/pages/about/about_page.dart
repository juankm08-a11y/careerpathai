import 'package:careerpathai/core/constants/app_texts.dart';
import 'package:careerpathai/presentation/controllers/supabase_controller/app_controller.dart';
import 'package:careerpathai/presentation/widgets/buttons/custom_appbar.dart';
import 'package:careerpathai/presentation/widgets/buttons/custom_radio_button.dart';
import 'package:careerpathai/presentation/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final appCtrl = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    String selectedOption = "Info";

    return Scaffold(
      appBar: CustomAppbar(
        title: AboutTexts.title.tr,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AboutTexts.title.tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              AboutTexts.options.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CustomRadioButton<String>(
              label: AboutTexts.history.tr,
              value: "History",
              groupValue: selectedOption,
              onChanged: (v) => {setState(() => selectedOption = v!)},
            ),
            CustomRadioButton<String>(
              label: AboutTexts.help.tr,
              value: "Help",
              groupValue: selectedOption,
              onChanged: (v) => {setState(() => selectedOption = v!)},
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    CustomDialog.show(
                        context: context,
                        title: "Information",
                        content: AboutTexts.selected.tr);
                  },
                  child: Text(AboutTexts.showInformation.tr)),
            )
          ],
        ),
      ),
    );
  }
}
