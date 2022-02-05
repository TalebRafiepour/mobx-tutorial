import 'package:shared_preferences/shared_preferences.dart';

class MPreferences {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  static const _locale = 'Locale';
  static const _theme = 'Theme';

  Future<void> setLocale(String languageCode) async {
    (await _preferences).setString(_locale, languageCode);
  }

  Future<String> getLocale() async {
    final languageCode = (await _preferences).getString(_locale) ?? 'en';
    print('selected language code: $languageCode');
    return languageCode;
  }

  Future<void> setThemeMode(String themeMode) async {
    (await _preferences).setString(_theme, themeMode);
  }

  Future<String> getThemeMode() async {
    final themeMode = (await _preferences).getString(_theme) ?? 'system';
    return themeMode;
  }
}
