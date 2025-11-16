import 'package:careerpathai/presentation/controllers/career_controller.dart';
import 'package:careerpathai/presentation/widgets/career_card_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CareerListPage extends StatelessWidget {
  CareerListPage({super.key});

  final CareerController _ctrl = Get.find<CareerController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("recommended careers".tr),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (_ctrl.loading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_ctrl.careers.isEmpty) {
          return const Center(
            child: Text(
              "No recommendations Available",
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ListView(
            children: [_buildCategorySection("Top Matches", _ctrl.careers)],
          ),
        );
      }),
    );
  }

  Widget _buildCategorySection(String title, List careers) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: careers.length,
            itemBuilder: (context, i) {
              final c = careers[i];
              return GestureDetector(
                onTap: () => Get.toNamed('/careerDetail', arguments: c),
                child: Hero(
                  tag: c.id,
                  child: CareerCardHorizontal(careerEntity: c),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
