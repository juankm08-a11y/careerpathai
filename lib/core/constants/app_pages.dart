import 'package:careerpathai/core/constants/app_routes.dart';
import 'package:careerpathai/main.dart';
import 'package:careerpathai/presentation/pages/about/about_page.dart';
import 'package:careerpathai/presentation/pages/career/career_compare_page.dart';
import 'package:careerpathai/presentation/pages/career/career_detail_page.dart';
import 'package:careerpathai/presentation/pages/career/careerlist_page.dart';
import 'package:careerpathai/presentation/pages/home/home_page.dart';
import 'package:careerpathai/presentation/pages/auth/login_page.dart';
import 'package:careerpathai/presentation/pages/profile/profile_page.dart';
import 'package:careerpathai/presentation/pages/auth/register_page.dart';
import 'package:careerpathai/presentation/pages/test_results/results_page.dart';
import 'package:careerpathai/presentation/pages/test_results/test_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.home, page: () => const HomePage()),
    GetPage(name: AppRoutes.welcome, page: () => const WelcomeScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage(name: AppRoutes.register, page: () => const RegisterPage()),
    GetPage(name: AppRoutes.test, page: () => const TestPage()),
    GetPage(name: AppRoutes.about, page: () => const AboutPage()),
    GetPage(name: AppRoutes.profile, page: () => const ProfilePage()),
    GetPage(name: AppRoutes.results, page: () => const ResultsPage()),
    GetPage(name: AppRoutes.careerListPage, page: () => CareerListPage()),
    GetPage(name: AppRoutes.careerDetailPage, page: () => CareerDetailPage()),
    GetPage(
      name: AppRoutes.careerComparePage,
      page: () => CareerComparePage(careersToCompare: Get.arguments),
    ),
  ];
}
