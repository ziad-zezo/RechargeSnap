import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  Future<bool> isOnboardingCompleted() async {
      final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
      return await asyncPrefs.getBool('onboardingCompleted') ?? false;
  }
  Future<void> setOnboardingCompleted() async {
      final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
      await asyncPrefs.setBool('onboardingCompleted', true);
  }
}


//is onboardin