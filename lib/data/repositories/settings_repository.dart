import 'package:todo_mobx/data/providers/storage/preferences/m_preferences.dart';

class SettingsRepository {
  final MPreferences _preferences;

  SettingsRepository(this._preferences);

  Future<void> setLocale(String languageCode) {
    return _preferences.setLocale(languageCode);
  }

  Future<String> getLocale() {
    return _preferences.getLocale();
  }
}
