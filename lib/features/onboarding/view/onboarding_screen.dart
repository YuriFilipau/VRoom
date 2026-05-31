import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vroom/core/constants/app_colors.dart';
import 'package:vroom/core/constants/app_sizes.dart';
import 'package:vroom/core/localization/app_language.dart';
import 'package:vroom/core/localization/app_localizations.dart';
import 'package:vroom/core/localization/bloc/language_bloc.dart';
import 'package:vroom/core/router/app_routes.dart';
import 'package:vroom/core/shared/widgets/app_gradient_button.dart';
import 'package:vroom/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:vroom/features/onboarding/view/components/onboarding_indicator.dart';
import 'package:vroom/features/onboarding/view/components/onboarding_language_page.dart';
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
  late final bool _includesLanguageSelection;
  late final bool _showsContentPages;
  late AppLanguage _selectedLanguage;
  int _currentPage = 0;
  bool _isSubmitting = false;
  static const _contentPageCount = 3;

  @override
  void initState() {
    super.initState();
    final languageState = context.read<LanguageBloc>().state;
    _pageController = PageController();
    _includesLanguageSelection = !languageState.hasSelectedLanguage;
    _showsContentPages = widget.onboardingRepository.shouldShowOnboarding();
    _selectedLanguage = languageState.effectiveLanguage;
  }

  List<OnboardingPageData> _pages(AppLocalizations l10n) {
    return [
      OnboardingPageData(
        title: l10n.onboardingWelcomeTitle,
        description: l10n.onboardingWelcomeDescription,
        icon: Icons.monitor_heart_outlined,
      ),
      OnboardingPageData(
        title: l10n.onboardingProfessionTitle,
        description: l10n.onboardingProfessionDescription,
        icon: Icons.precision_manufacturing_outlined,
      ),
      OnboardingPageData(
        title: l10n.onboardingAchievementsTitle,
        description: l10n.onboardingAchievementsDescription,
        icon: Icons.emoji_events_outlined,
      ),
    ];
  }

  int get _pageCount =>
      (_showsContentPages ? _contentPageCount : 0) +
      (_includesLanguageSelection ? 1 : 0);

  bool get _isLanguagePage => _includesLanguageSelection && _currentPage == 0;

  bool get _isLastPage => _currentPage == _pageCount - 1;

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
    if (_isLanguagePage) {
      context.read<LanguageBloc>().add(
        LanguageEvent.selected(_selectedLanguage),
      );
    }

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
    final l10n = AppLocalizations.of(context);
    final selectedLanguageCopy = AppLocalizations.forLanguage(
      _selectedLanguage,
    );
    final pages = _pages(l10n);
    final visiblePageCount =
        (_showsContentPages ? pages.length : 0) +
        (_includesLanguageSelection ? 1 : 0);

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
              if (!_isLanguagePage)
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
                      child: Text(l10n.onboardingSkip),
                    ),
                  ),
                ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: visiblePageCount,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    if (_includesLanguageSelection && index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppSizes.spacing8,
                        ),
                        child: OnboardingLanguagePage(
                          selectedLanguage: _selectedLanguage,
                          onLanguageSelected: (language) {
                            setState(() {
                              _selectedLanguage = language;
                            });
                          },
                        ),
                      );
                    }

                    final pageIndex = _includesLanguageSelection
                        ? index - 1
                        : index;

                    return OnboardingPageContent(page: pages[pageIndex]);
                  },
                ),
              ),
              OnboardingIndicator(
                count: visiblePageCount,
                currentIndex: _currentPage,
              ),
              const SizedBox(height: AppSizes.spacing24),
              AppGradientButton(
                label: _isLastPage
                    ? l10n.onboardingStart
                    : _isLanguagePage
                    ? selectedLanguageCopy.continueAction
                    : l10n.onboardingNext,
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
