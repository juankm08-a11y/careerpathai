import 'package:careerpathai/core/constants/app_colors.dart';
import 'package:careerpathai/domain/entities/career_entity.dart';
import 'package:careerpathai/presentation/widgets/career_card.dart';
import 'package:careerpathai/presentation/widgets/empty_state.dart';
import 'package:careerpathai/presentation/widgets/filter_chip_group.dart';
import 'package:careerpathai/presentation/widgets/info_title.dart';
import 'package:flutter/material.dart';

class CareerListPage extends StatefulWidget {
  const CareerListPage({super.key});

  @override
  State<CareerListPage> createState() => _CareerListPageState();
}

class _CareerListPageState extends State<CareerListPage> {
  final List<CareerEntity> careers = [
    CareerEntity(
      id: '1',
      title: 'Software Engineer',
      description: 'Design and develop software systems and applications',
      score: 92.5,
    ),
  ];

  final List<String> filters = ['Technology', 'Design', 'Health', 'Science'];
  final Set<String> selectedFilters = {};

  void toogleFilter(String item) {
    setState(() {
      if (selectedFilters.contains(item)) {
        selectedFilters.remove(item);
      } else {
        selectedFilters.add(item);
      }
    });
  }

  void showCareerInfo(CareerEntity career) {
    showDialog(
      context: context,
      builder: (_) =>
          InfoTitle(title: career.title, subtitle: career.description),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredCareers = selectedFilters.isEmpty
        ? careers
        : careers.where((c) => selectedFilters.contains('Technology')).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Careers'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FilterChipGroup(
              items: filters,
              selected: selectedFilters,
              onToogle: toogleFilter,
            ),
            const SizedBox(height: 20),

            if (filteredCareers.isEmpty)
              const Expanded(
                child: EmptyState(
                  title: 'Careers',
                  subtitle: 'No Careers found for your filters.',
                ),
              )
            else
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    final career = filteredCareers[index];
                    return CareerCard(
                      career: career,
                      onTap: () => showCareerInfo(career),
                    );
                  },
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemCount: filteredCareers.length,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
