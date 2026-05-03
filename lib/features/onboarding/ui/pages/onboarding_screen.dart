import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/components/page_indicator.dart';
import '../../../../core/components/custom_button.dart';
import '../../../auth/ui/pages/account_type_screen.dart';

/// Onboarding Screen with PageView
/// 3 screens: Practice Mindfulness, Connect with Professionals, Track Your Journey
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToAccountType();
    }
  }

  void _navigateToAccountType() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const AccountTypeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: _navigateToAccountType,
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray500,
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: const [
                  OnboardingPage(
                    imagePath: 'assets/images/onboarding/onboarding1.png',
                    title: 'Practice Mindfulness',
                    description:
                        'Discover guided meditation sessions and breathing exercises designed to reduce stress and bring calm to your daily life.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/onboarding/onboarding2.png',
                    title: 'Connect with Professionals',
                    description:
                        'Access licensed therapists and counselors who understand your journey and are here to support your mental wellness.',
                  ),
                  OnboardingPage(
                    imagePath: 'assets/images/onboarding/onboarding_growth.jpg',
                    title: 'Track Your Journey',
                    description:
                        'Monitor your emotional wellness, set goals, and celebrate your progress as you grow stronger each day.',
                  ),
                ],
              ),
            ),

            // Footer with Page Indicators and Next Button
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingLg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PageIndicator(
                    currentPage: _currentPage,
                    pageCount: 3,
                  ),
                  RoundedButton(
                    text: _currentPage == 2 ? 'Get Started' : 'Next',
                    onPressed: _nextPage,
                    isPrimary: _currentPage == 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual Onboarding Page
class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Expanded(
            flex: 2,
            child: Center(
              child: Image.asset(
                imagePath,
                width: 280,
                height: 280,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: AppTheme.spacing2xl),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.gray800,
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: AppTheme.spacingMd),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.gray500,
              height: 1.7,
            ),
          ),

          const SizedBox(height: AppTheme.spacing2xl),
        ],
      ),
    );
  }
}
