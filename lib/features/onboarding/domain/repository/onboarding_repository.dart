abstract interface class OnboardingRepository {
  bool shouldShowOnboarding();

  Future<void> completeOnboarding();
}
