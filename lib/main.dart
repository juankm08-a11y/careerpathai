import 'dart:math';
import 'dart:ui';

import 'package:careerpathai/core/translations/app_translations.dart';
import 'package:careerpathai/presentation/controllers/app_controller.dart';
import 'package:careerpathai/presentation/pages/about_page.dart';
import 'package:careerpathai/presentation/pages/home_page.dart';
import 'package:careerpathai/presentation/pages/profile_page.dart';
import 'package:careerpathai/presentation/pages/register_page.dart';
import 'package:careerpathai/presentation/pages/results_page.dart';
import 'package:careerpathai/presentation/pages/test_page.dart';
import 'package:flutter/material.dart';
import './core/config/supabase_config.dart';
import './presentation/pages/login_page.dart';
import 'package:get/get.dart';
import './presentation/controllers/career_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Cargando variables de entorno");
  await dotenv.load(fileName: ".env");
  print("Variables cargadas correctamente");

  print("Inicializando supabase");
  await SupabaseConfig.initialize();
  print("Supabase inicio correctamente");

  Get.put(AppController(), permanent: true);
  Get.put(CareerController());

  runApp(const CareerPathAI());
}

class CareerPathAI extends StatelessWidget {
  const CareerPathAI({super.key});

  @override
  Widget build(BuildContext context) {
    final appCtrl = Get.find<AppController>();
    
    return Obx(
      () => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: const Locale('en','US'),

      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: appCtrl.isDark.value ? ThemeMode.dark : ThemeMode.light,
    
      initialRoute: "/welcome",
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/welcome', page: () => const WelcomeScreen()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/test', page: () => const TestPage()),
        GetPage(name: '/about', page: () => const AboutPage()),
        GetPage(name: '/profile', page: () => const ProfilePage()),
        GetPage(
          name: '/career_recommendations',
          page: () => const ResultsPage(),
        ),
      ],
    );
    )
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _cardOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _logoScale = Tween<double>(
      begin: 0.05,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeIn),
      ),
    );

    _cardOffset = Tween<Offset>(
      begin: const Offset(0, 0.003),
      end: const Offset(0, -0.02),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Get.to(() => const LoginPage(), transition: Transition.downToUp);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6C5CE7), Color(0xFF3B82F6)],
              ),
            ),
          ),
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: _BlobsPainter(progress: _controller.value),
                );
              },
            ),
          ),
          SafeArea(
            child: Center(
              child: SlideTransition(
                position: _cardOffset,
                child: FadeTransition(
                  opacity: _fadeIn,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.06,
                      vertical: 24,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 760),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 30,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.08),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.18),
                                blurRadius: 24,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ScaleTransition(
                                scale: _logoScale,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFFFE082),
                                        Color(0xFFFF7043),
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.2,
                                        ),
                                        blurRadius: 10,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(18),
                                  child: const Icon(
                                    Icons.school_rounded,
                                    size: 56,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),

                              const Text(
                                'Welcome to CareerPathAI',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                'Discover your ideal career with the help of artificial intelligence. Take a short test and receive personalized recommendations.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white70,
                                ),
                              ),

                              const SizedBox(height: 20),

                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _goToLogin();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF7C4DFF),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 26,
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 10,
                                      shadowColor: Colors.black.withValues(
                                        alpha: 0.32,
                                      ),
                                    ),

                                    child: const Text(
                                      'Start',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),

                                  OutlinedButton(
                                    onPressed: _goToLogin,
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: Colors.white.withValues(
                                          alpha: 0.18,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 22,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text('Login'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              const Text(
                                'Your privacy is important. Your responses are used only to generate recommendations.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlobsPainter extends CustomPainter {
  final double progress;
  _BlobsPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();

    void drawBlob(Offset center, double radius, Color color, double alpha) {
      final gradient = RadialGradient(
        colors: [color.withValues(alpha: 0.22), color.withValues(alpha: 0.0)],
      );
      final rect = Rect.fromCircle(center: center, radius: radius);
      paint.shader = gradient.createShader(rect);
      canvas.drawCircle(center, radius, paint);
      paint.shader = null;
    }

    final double t = progress * 2 * pi;

    final Offset c1 = Offset(
      size.width * 0.15 + sin(t * 0.9) * size.width * 0.01,
      size.height * 0.16 + cos(t * 0.6) * size.height * 0.01,
    );

    drawBlob(
      c1,
      min(size.width, size.height) * 0.32,
      const Color(0xFF8B5CF6),
      0.28,
    );

    final Offset c2 = Offset(
      size.width * 0.86 + sin(t * 1.1) * size.width * 0.005,
      size.height * 0.28 + cos(t * 0.8) * size.height * 0.01,
    );

    drawBlob(
      c2,
      min(size.width, size.height) * 0.2,
      const Color(0xFF3B82F6),
      0.20,
    );

    final Offset c3 = Offset(
      size.width * 0.28 + sin(t * 0.7) * size.width * 0.007,
      size.height * 0.84 + cos(t * 1.3) * size.height * 0.01,
    );

    drawBlob(
      c3,
      min(size.width, size.height) * 0.28,
      const Color(0xFF00C2FF),
      0.18,
    );

    final Offset c4 = Offset(
      size.width * 0.75 + sin(t * 1.6) * size.width * 0.01,
      size.height * 0.78 + cos(t * 1.1) * size.height * 0.008,
    );

    drawBlob(
      c4,
      min(size.width, size.height) * 0.12,
      const Color(0xFFFFB86B),
      0.22,
    );
  }

  @override
  bool shouldRepaint(covariant _BlobsPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
