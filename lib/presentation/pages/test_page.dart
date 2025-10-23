import 'package:careerpathai/services/gemini_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../presentation/controllers/career_controller.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final Map<String, dynamic> profile = {
    'interests': <String>[],
    'skills': <String>[],
    'personality': '',
    'favoriteSubjects': '',
  };

  final TextEditingController interestsCtrl = TextEditingController();
  final TextEditingController skillsCtrl = TextEditingController();
  final TextEditingController personalityCtrl = TextEditingController();
  final TextEditingController subjectsCtrl = TextEditingController();

  final List<String> preferenceOptions = [
    'Prefiero trabajar en equipo',
    'Me gusta resolver problemas lógicos',
    'Disfruto ayudar a los demás',
    'Me atraen los retos tecnológicos',
    'Prefiero trabajos con creatividad',
    'Me gustariía tener mi propio negocio',
  ];

  final Set<String> selectedPreferences = {};

  @override
  void dispose() {
    interestsCtrl.dispose();
    skillsCtrl.dispose();
    personalityCtrl.dispose();
    subjectsCtrl.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 3) {
      setState(() {
        _currentPage++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submit() async {
    final ctrl = Get.find<CareerController>();
    profile['interests'] = interestsCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    profile['skills'] = skillsCtrl.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    profile['personality'] = personalityCtrl.text.trim();
    profile['favoriteSubjects'] = subjectsCtrl.text.trim();
    profile['preferences'] = selectedPreferences.toList();

    final aiResponse = await GeminiService.getCareerRecommendations(profile);

    ctrl.setAIRecommendations(aiResponse);
    Get.toNamed('/career_recommendations');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test vocacional')),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildQuestion(
                      '¿Cuáles son tus principales intereses?',
                      'ej:programación, diseño,música, ayudar a otros',
                      interestsCtrl,
                    ),
                    _buildQuestion(
                      '¿Qué habilidades o conocimientos consideras que tienes?',
                      'ej:Python,comunicación, liderazgo',
                      skillsCtrl,
                    ),
                    _buildQuestion(
                      '¿Cómo describirías tu personalidad?',
                      'ej:¿analítico, creativo,empático...?',
                      personalityCtrl,
                    ),
                    _buildMultipleChoice(
                      'Que afirmaciones se parecen más a ti',
                      preferenceOptions,
                      selectedPreferences,
                    ),
                    _buildQuestion(
                      '¿Cuáles eran tus materias favoritas en el colegio?',
                      'ej:¿matemáticas, arte, biología?',
                      subjectsCtrl,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    IconButton(
                      onPressed: _previousPage,
                      icon: const Icon(Icons.arrow_back),
                    )
                  else
                    const SizedBox(width: 40),

                  if (_currentPage < 3)
                    IconButton(
                      onPressed: _nextPage,
                      icon: const Icon(Icons.arrow_forward),
                    )
                  else
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Finalizar'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion(
    String title,
    String hint,
    TextEditingController controller,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildMultipleChoice(
    String title,
    List<String> options,
    Set<String> selected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: options.map((option) {
              final isSelected = selected.contains(option);
              return CheckboxListTile(
                value: isSelected,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selected.add(option);
                    } else {
                      selected.remove(option);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
