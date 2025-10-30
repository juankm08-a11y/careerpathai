import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text('profile'.tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(user?.email ?? '---'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: logout, child: Text('logout'.tr)),
          ],
        ),
      ),
    );
  }
}
