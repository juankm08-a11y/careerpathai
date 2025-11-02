import 'package:careerpathai/presentation/widgets/app_button.dart';
import 'package:careerpathai/presentation/widgets/custom_checkbox.dart';
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
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  bool _acceptTerms = false;
  bool _loading = false;

  Future<void> _onRegister() async {
    if (_nameCtrl.text.isEmpty ||
        _emailCtrl.text.isEmpty ||
        _passwordCtrl.text.isEmpty ||
        !_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields")),
      );
      return;
    }

    setState(() => _loading = true);

    await Future.delayed(const Duration(seconds: 1));

    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account created successfully")),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _loading,
      child: Scaffold(
        appBar: AppBar(title: Text('register'.tr)),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InputField(label: 'Full Name', controller: _nameCtrl),
                const SizedBox(height: 15),
                InputField(
                  label: "Email",
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                InputField(
                  label: "Password",
                  controller: _passwordCtrl,
                  obscure: true,
                ),
                const SizedBox(height: 15),
                CustomCheckbox(
                  value: _acceptTerms,
                  onChanged: (v) => setState(() => _acceptTerms = v ?? false),
                  label: "I accept terms and conditions",
                ),
                const SizedBox(height: 25),
                AppButton(onPressed: _onRegister, text: "Register"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
