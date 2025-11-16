import 'package:careerpathai/core/constants/app_routes.dart';
import 'package:careerpathai/main.dart';
import 'package:careerpathai/presentation/pages/about_page.dart';
import 'package:careerpathai/presentation/pages/careerlist_page.dart';
import 'package:careerpathai/presentation/pages/home_page.dart';
import 'package:careerpathai/presentation/pages/login_page.dart';
import 'package:careerpathai/presentation/pages/profile_page.dart';
import 'package:careerpathai/presentation/pages/register_page.dart';
import 'package:careerpathai/presentation/pages/results_page.dart';
import 'package:careerpathai/presentation/pages/test_page.dart';
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
  ];
}
