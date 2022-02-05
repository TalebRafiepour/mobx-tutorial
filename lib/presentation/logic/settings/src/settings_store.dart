import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx/core/consts/m_consts.dart';
import 'package:todo_mobx/data/repositories/settings_repository.dart';

part 'settings_store.g.dart';

class SettingsStore = _SettingsStore with _$SettingsStore;

abstract class _SettingsStore with Store {
  final SettingsRepository _settingsRepository;

  _SettingsStore(this._settingsRepository);

  @observable
  Locale selectedLocale = MConstants.locales[0];

  @computed
  ThemeMode get themeMode => _themeMode;

  @observable
  ThemeMode _themeMode = ThemeMode.system;

  @observable
  bool isLoading = false;

  @observable
  bool changesSaved = false;

  @action
  Future<void> setLocale() async {
    changesSaved = false;
    isLoading = true;
    await _settingsRepository.setLocale(selectedLocale.languageCode);
    isLoading = false;
    changesSaved = true;
  }

  @action
  Future<void> setTheme(ThemeMode mode) async {
    isLoading = true;
    _themeMode = mode;
    await _settingsRepository.setThemeMode(mode);
    isLoading = false;
  }

  @action
  Future<void> init() async {
    final languageCode = await _settingsRepository.getLocale();
    final themeMode = await _settingsRepository.getThemeMode();
    selectedLocale = Locale(languageCode);
    _themeMode = themeMode;
    changesSaved = false;
  }
}
