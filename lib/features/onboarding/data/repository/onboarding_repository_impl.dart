import 'package:vroom/features/onboarding/data/datasource/onboarding_local_datasource.dart';
import 'package:vroom/features/onboarding/domain/repository/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl({
    required OnboardingLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final OnboardingLocalDataSource _localDataSource;

  @override
  bool shouldShowOnboarding() {
    return _localDataSource.shouldShowOnboarding();
  }

  @override
  Future<void> completeOnboarding() {
    return _localDataSource.completeOnboarding();
  }
}
