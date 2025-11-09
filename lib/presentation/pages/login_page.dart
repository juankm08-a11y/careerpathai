import 'package:careerpathai/core/constants/app_constants.dart';
import 'package:careerpathai/presentation/widgets/app_logo.dart';

import 'package:careerpathai/presentation/widgets/custom_text_button.dart';
import 'package:careerpathai/presentation/widgets/gradient_background.dart';
import 'package:careerpathai/presentation/widgets/loading_button.dart';
import 'package:careerpathai/presentation/widgets/spaced_column.dart';
import 'package:careerpathai/presentation/widgets/ucc_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();
  final TextEditingController confirmCtrl = TextEditingController();

  bool loading = false;

  Future<void> login() async {
    if (emailCtrl.text.isEmpty || passCtrl.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    setState(() => loading = true);

    try {
      final res = await Supabase.instance.client.auth.signInWithPassword(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );

      if (res.session != null) {
        Get.offAllNamed('/home');
      } else {
        Get.snackbar("Error", "Invalid credentials");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: SpacedColumn(
                  gap: 20,
                  children: [
                    const AppLogo(size: 100),
                    Text(
                      'Create Your Account',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    InputField(
                      controller: emailCtrl,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    InputField(
                      label: 'Password',
                      controller: passCtrl,
                      obscure: true,
                    ),
                    InputField(
                      controller: confirmCtrl,
                      obscure: true,
                      label: 'Confirm Password',
                    ),
                    Align(alignment: Alignment.centerRight),
                    LoadingButton(
                      loading: loading,
                      onPressed: login,
                      label: "Sign In",
                    ),
                    CustomTextButton(
                      label: "Create an account",
                      onPressed: () => Get.toNamed(AppRoutes.register),
                    ),
                    const SizedBox(height: 20),
                    const UccBanner(text: 'UCC'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
