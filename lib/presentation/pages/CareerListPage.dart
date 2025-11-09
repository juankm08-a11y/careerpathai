import 'package:careerpathai/domain/entities/career_entity.dart';
import 'package:careerpathai/presentation/widgets/info_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    // TODO: implement build
    throw UnimplementedError();
  }
}
