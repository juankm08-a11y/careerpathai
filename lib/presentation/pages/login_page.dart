import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:careerpathai/presentation/pages/test_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool loading = false;

  Future<void> _signIn() async {
    if (_email.text.isEmpty || _pass.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please, fill in all the fields')),
      );
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final res = await Supabase.instance.client.auth.signInWithPassword(
        email: _email.text,
        password: _pass.text,
      );

      if (res.session != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Login successfully')));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const TestPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al iniciar sesión')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Login', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                TextField(
                  controller: _email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _pass,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 14),
                ElevatedButton.icon(
                  onPressed: loading ? null : _signIn,
                  icon: const Icon(Icons.login),
                  label: const Text('Entrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: loading ? null : _signIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text(
                    "Enter",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const TestPage()),
                    );
                  },
                  child: const Text("Enter as guest"),
                ),
              ],
            ),
          ),
          if (loading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}
