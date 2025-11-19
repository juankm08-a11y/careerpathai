import 'package:careerpathai/core/constants/app_routes.dart';
import 'package:careerpathai/presentation/widgets/logo/app_logo.dart';

import 'package:careerpathai/presentation/widgets/buttons/custom_text_button.dart';
import 'package:careerpathai/presentation/widgets/gradient_background/gradient_background.dart';
import 'package:careerpathai/presentation/widgets/buttons/loading_button.dart';
import 'package:careerpathai/presentation/widgets/spaced_column/spaced_column.dart';
import 'package:careerpathai/presentation/widgets/banner/ucc_banner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../widgets/field/input_field.dart';

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
      Get.snackbar(
        "Error",
        "Please fill all fields",
        backgroundColor: Colors.red.shade100,
      );
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
        Get.snackbar(
          "Error",
          "Invalid credentials",
          backgroundColor: Colors.red.shade100,
        );
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          message: e.toString(),
          backgroundColor: Colors.red.shade100,
          duration: const Duration(seconds: 2),
        ),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                      'Sign In',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
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
                      textColor: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 25),
                    const UccBanner(
                      text: '© 2025 Universidad Cooperativa de Colombia',
                    ),
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
