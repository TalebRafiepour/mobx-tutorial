import 'dart:ui';

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
  Future<void> init() async {
    final languageCode = await _settingsRepository.getLocale();
    selectedLocale = Locale(languageCode);
    changesSaved = false;
  }
}
