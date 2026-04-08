abstract interface class OnboardingLocalDataSource {
  bool shouldShowOnboarding();

  Future<void> completeOnboarding();
}
