import 'package:recharge_snap/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsHelper {
  static const String defaultProviderKey = 'defaultProvider';

  static Future<void> setDefaultProvider(String provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(defaultProviderKey, provider);
  }

  static Future<String?> getDefaultProvider() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(defaultProviderKey) ?? etisalat;
  }
}
