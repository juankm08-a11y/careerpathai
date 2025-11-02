import 'package:careerpathai/presentation/widgets/app_button.dart';
import 'package:careerpathai/presentation/widgets/input_field.dart';
import 'package:careerpathai/presentation/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool loading = false;

  Future<void> register() async {
    setState(() => loading = true);

    try {
      final res = await Supabase.instance.client.auth.signUp(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );
      if (res.user != null) {
        print("Account created successfully");
        Get.offAllNamed("/login");
      } else {
        print("Could not create account");
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: loading,
      child: Scaffold(
        appBar: AppBar(title: Text('register'.tr)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              InputField(controller: emailCtrl, label: 'email'.tr),
              const SizedBox(height: 14),
              InputField(controller: passCtrl, label: 'password'.tr),
              const SizedBox(height: 20),
              AppButton(text: 'register'.tr, onPressed: register),
            ],
          ),
        ),
      ),
    );
  }
}
