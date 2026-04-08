import 'package:shared_preferences/shared_preferences.dart';
import 'package:vroom/features/onboarding/data/datasource/onboarding_local_datasource.dart';

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  OnboardingLocalDataSourceImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  static const _onboardingCompletedKey = 'onboarding_completed';

  final SharedPreferences _sharedPreferences;

  @override
  bool shouldShowOnboarding() {
    return !(_sharedPreferences.getBool(_onboardingCompletedKey) ?? false);
  }

  @override
  Future<void> completeOnboarding() {
    return _sharedPreferences.setBool(_onboardingCompletedKey, true);
  }
}
