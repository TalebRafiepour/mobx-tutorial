import 'package:flutter/material.dart';
import 'package:todo_mobx/data/providers/storage/preferences/m_preferences.dart';

class SettingsRepository {
  final MPreferences _preferences;

  SettingsRepository(this._preferences);

  Future<void> setLocale(String languageCode) {
    return _preferences.setLocale(languageCode);
  }

  Future<void> setThemeMode(ThemeMode themeMode) {
    final String theme = themeMode == ThemeMode.dark
        ? 'dark'
        : themeMode == ThemeMode.light
            ? 'light'
            : 'system';
    return _preferences.setThemeMode(theme);
  }

  Future<ThemeMode> getThemeMode() async {
    final theme = await _preferences.getThemeMode();
    final ThemeMode themeMode = theme == 'dark'
        ? ThemeMode.dark
        : theme == 'light'
            ? ThemeMode.light
            : ThemeMode.system;

    return themeMode;
  }

  Future<String> getLocale() {
    return _preferences.getLocale();
  }
}
