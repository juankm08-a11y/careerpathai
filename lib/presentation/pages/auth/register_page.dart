import 'package:careerpathai/core/constants/app_texts.dart';
import 'package:careerpathai/presentation/widgets/buttons/app_button.dart';
import 'package:careerpathai/presentation/widgets/checkbox/custom_checkbox.dart';
import 'package:careerpathai/presentation/widgets/field/input_field.dart';
import 'package:careerpathai/presentation/widgets/loading_overlay/loading_overlay.dart';
import 'package:careerpathai/presentation/widgets/banner/ucc_banner.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool _acceptTerms = false;
  bool _loading = false;

  Future<void> _onRegister() async {
    // Validaciones
    if (_nameCtrl.text.isEmpty ||
        _emailCtrl.text.isEmpty ||
        _passwordCtrl.text.isEmpty ||
        !_acceptTerms) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(RegisterTexts.completeFields)),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      await Supabase.instance.client.auth.signUp(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
      );

      if (!mounted) return;

      setState(() => _loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(RegisterTexts.accountCreated),
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withValues(alpha: 0.8),
        ),
      );

      Get.offAllNamed("/login");
    } catch (e) {
      if (!mounted) return;

      setState(() => _loading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LoadingOverlay(
      isLoading: _loading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(RegisterTexts.title.tr),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputField(
                    label: RegisterTexts.fullName.tr, controller: _nameCtrl),
                const SizedBox(height: 15),
                InputField(
                  label: RegisterTexts.email.tr,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                InputField(
                  label: RegisterTexts.password.tr,
                  controller: _passwordCtrl,
                  obscure: true,
                ),
                const SizedBox(height: 15),
                CustomCheckbox(
                  value: _acceptTerms,
                  onChanged: (v) => setState(() => _acceptTerms = v ?? false),
                  label: RegisterTexts.acceptTerms.tr,
                  activeColor: theme.colorScheme.primary,
                ),
                const SizedBox(height: 25),
                AppButton(
                    onPressed: _onRegister, text: RegisterTexts.button.tr),
                UccBanner(text: LoginTexts.footer.tr),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
