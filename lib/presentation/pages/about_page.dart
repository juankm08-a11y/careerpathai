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
          children: const [
            Text(
              'Sobre la Universidad Cooperativa de Colombia',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'La UCC es una institución educativa con presencia en toda Colombia.'
              'enfocada en formar profesionales competentes, emprendedore y con visión social.',
            ),
          ],
        ),
      ),
    );
  }
}
