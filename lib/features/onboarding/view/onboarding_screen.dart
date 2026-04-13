import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/core/shared/widgets/app_gradient_button.dart';
import 'package:vroom/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:vroom/features/onboarding/view/components/onboarding_indicator.dart';
import 'package:vroom/features/onboarding/view/components/onboarding_page_content.dart';
import 'package:vroom/features/onboarding/view/onboarding_page_data.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({required this.onboardingRepository, super.key});

  final OnboardingRepository onboardingRepository;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  late final List<OnboardingPageData> _pages;
  int _currentPage = 0;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pages = const [
      OnboardingPageData(
        title: 'Добро пожаловать в ARient',
        description:
            'Исследуй профессии будущего через AR-квесты с дополненной реальностью',
        icon: Icons.monitor_heart_outlined,
      ),
      OnboardingPageData(
        title: 'Погрузись в профессию',
        description:
            'Попробуй себя в роли инженера, врача, дизайнера в дополненной реальности',
        icon: Icons.precision_manufacturing_outlined,
      ),
      OnboardingPageData(
        title: 'Получай достижения',
        description:
            'Проходи квесты, отвечай на вопросы и открывай новые награды',
        icon: Icons.emoji_events_outlined,
      ),
    ];
  }

  bool get _isLastPage => _currentPage == _pages.length - 1;

  Future<void> _finishOnboarding() async {
    if (_isSubmitting) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    await widget.onboardingRepository.completeOnboarding();

    if (!mounted) {
      return;
    }

    context.go(AppRoutes.login.path);
  }

  Future<void> _onPrimaryPressed() async {
    if (_isLastPage) {
      await _finishOnboarding();
      return;
    }

    await _pageController.nextPage(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSizes.screenHorizontalPadding,
            AppSizes.screenTopPadding,
            AppSizes.screenHorizontalPadding,
            AppSizes.screenHorizontalPadding,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Visibility(
                  visible: !_isLastPage,
                  maintainState: true,
                  maintainAnimation: true,
                  maintainSize: true,
                  child: TextButton(
                    onPressed: _isSubmitting ? null : _finishOnboarding,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      disabledForegroundColor: AppColors.textSecondary,
                    ),
                    child: const Text('Пропустить'),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _pages.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingPageContent(page: _pages[index]);
                  },
                ),
              ),
              OnboardingIndicator(
                count: _pages.length,
                currentIndex: _currentPage,
              ),
              const SizedBox(height: AppSizes.spacing24),
              AppGradientButton(
                label: _isLastPage ? 'Начать' : 'Далее',
                onPressed: _onPrimaryPressed,
                isLoading: _isSubmitting,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
