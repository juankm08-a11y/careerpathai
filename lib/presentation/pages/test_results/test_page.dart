import 'package:careerpathai/core/constants/app_routes.dart';
import 'package:careerpathai/core/constants/app_texts.dart';
import 'package:careerpathai/services/gemini_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/supabase_controller/career_controller.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _pagesCount = 5;

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
    'Team work'.tr,
    'Logical thinking'.tr,
    'Helping others'.tr,
    'Love for tecnology'.tr,
    'Creativity'.tr,
    'Entreprenurial spirit'.tr,
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
    if (_currentPage < _pagesCount - 1) {
      setState(() => _currentPage++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
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

    Get.toNamed(AppRoutes.results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextTests.startTest.tr),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.profile),
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.about),
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                      TextTests.interests.tr,
                      TextTests.interestHint.tr,
                      interestsCtrl,
                    ),
                    _buildQuestion(
                      TextTests.skills.tr,
                      TextTests.skillsHint.tr,
                      skillsCtrl,
                    ),
                    _buildQuestion(
                      TextTests.personality.tr,
                      TextTests.personalityHint.tr,
                      personalityCtrl,
                    ),
                    _buildMultipleChoice(
                      TextTests.preferences.tr,
                      preferenceOptions,
                      selectedPreferences,
                    ),
                    _buildQuestion(
                      TextTests.subjects.tr,
                      TextTests.subjectsHint.tr,
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
                    ElevatedButton(
                      onPressed: _previousPage,
                      child: Text(TextTests.back.tr),
                    )
                  else
                    const SizedBox(width: 80),
                  if (_currentPage < _pagesCount - 1)
                    ElevatedButton(
                        onPressed: _nextPage, child: Text(TextTests.next.tr))
                  else
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(TextTests.finish.tr),
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
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Theme.of(context).inputDecorationTheme.fillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultipleChoice(
    String title,
    List<String> options,
    Set<String> selected,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView(
              children: options.map((option) {
                final isSelected = selected.contains(option);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.1)
                        : Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade400,
                    ),
                  ),
                  child: CheckboxListTile(
                    activeColor: Theme.of(context).colorScheme.primary,
                    title: Text(
                      option,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        value == true
                            ? selected.add(option)
                            : selected.remove(option);
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
