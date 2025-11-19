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
        title: const Text('Comparison of careers'),
        backgroundColor: Colors.deepPurple,
      ),
      body: careersToCompare.isEmpty
          ? const Center(
              child: Text(
                "You didn't select any careers to compare",
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
      case 'description':
        return const Text('Profile');
      case 'skills':
        return const Text('Key Skills');
      case 'jobOpportunities':
        return const Text('Job Opportunities');
      case 'avgSalary':
        return const Text('Average Salary');
      case 'marketDemand':
        return const Text('Market Demand');
      case 'employability':
        return const Text('Employability');
      case 'trend':
        return const Text('Trend');
      default:
        return const Text('Unknown');
    }
  }

  Widget _getFieldValue(CareerEntity career, String field) {
    switch (field) {
      case 'description':
        return Text(career.description);
      case 'skills':
        return Text(career.skills.join(", "));
      case 'jobOpportunities':
        return Text(career.jobOpportunities);
      case 'avgSalary':
        final salary = career.avgSalary ?? 0;
        return Text("\$${salary.toStringAsFixed(0)} USD");
      case 'marketDemand':
        return Text(career.marketDemand ?? 'Unknown');
      case 'workEnvironment':
        return Text(career.workEnvironment ?? 'Unknown');
      case 'employability':
        return Text(
          career.employability != null
              ? "${career.employability!.toStringAsFixed(1)}%"
              : "Unknown",
        );
      case 'trend':
        return Text(career.trend ?? 'Unknown');
      default:
        return const Text('Unknown');
    }
  }
}
