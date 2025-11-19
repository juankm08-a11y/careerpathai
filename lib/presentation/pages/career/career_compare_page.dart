import 'package:careerpathai/core/constants/app_texts.dart';
import 'package:careerpathai/domain/entities/career_entity.dart';
import 'package:flutter/material.dart';

class CareerComparePage extends StatelessWidget {
  final List<CareerEntity> careersToCompare;

  const CareerComparePage({super.key, required this.careersToCompare});

  @override
  Widget build(BuildContext context) {
    final List<String> comparisonFields = [
      'description',
      'skills',
      'jobOpportunities',
      'avgSalary',
      'marketDemand',
      'workEnvironment',
      'employability',
      'trend',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(CareerTexts.comparisonOfCareers),
        backgroundColor: Colors.deepPurple,
      ),
      body: careersToCompare.isEmpty
          ? const Center(
              child: Text(
                CareerTexts.noCareersSelected,
                style: TextStyle(fontSize: 18),
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  const DataColumn(
                    label: Text(
                      "Category",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ...careersToCompare.map(
                    (career) => DataColumn(
                      label: Text(
                        career.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
                rows: comparisonFields.map((field) {
                  return DataRow(
                    cells: [
                      DataCell(_getFieldLabel(field)),
                      ...careersToCompare.map(
                        (career) => DataCell(_getFieldValue(career, field)),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }

  Widget _getFieldLabel(String field) {
    switch (field) {
      case CareerTexts.description:
        return const Text(CareerTexts.description);
      case CareerTexts.keySkills:
        return const Text(CareerTexts.keySkills);
      case CareerTexts.jobOpportunities:
        return const Text(CareerTexts.jobOpportunities);
      case CareerTexts.avgSalary:
        return const Text(CareerTexts.avgSalary);
      case CareerTexts.marketDemand:
        return const Text(CareerTexts.marketDemand);
      case CareerTexts.employability:
        return const Text(CareerTexts.employability);
      case CareerTexts.trend:
        return const Text(CareerTexts.trend);
      default:
        return const Text('Unknown');
    }
  }

  Widget _getFieldValue(CareerEntity career, String field) {
    switch (field) {
      case CareerTexts.description:
        return Text(career.description);
      case CareerTexts.keySkills:
        return Text(career.skills.join(", "));
      case CareerTexts.jobOpportunities:
        return Text(career.jobOpportunities);
      case CareerTexts.avgSalary:
        final salary = career.avgSalary ?? 0;
        return Text("\$${salary.toStringAsFixed(0)} USD");
      case CareerTexts.marketDemand:
        return Text(career.marketDemand ?? 'Unknown');
      case CareerTexts.workEnvironment:
        return Text(career.workEnvironment ?? 'Unknown');
      case CareerTexts.employability:
        return Text(
          career.employability != null
              ? "${career.employability!.toStringAsFixed(1)}%"
              : "Unknown",
        );
      case CareerTexts.trend:
        return Text(career.trend ?? 'Unknown');
      default:
        return const Text('Unknown');
    }
  }
}
