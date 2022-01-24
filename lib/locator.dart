import 'package:get_it/get_it.dart';
import 'package:todo_mobx/data/providers/api/profile_api.dart';
import 'package:todo_mobx/data/providers/api/user_api.dart';
import 'package:todo_mobx/data/providers/storage/preferences/m_preferences.dart';
import 'package:todo_mobx/data/providers/storage/secure/secure_storage.dart';
import 'package:todo_mobx/data/repositories/login_repository.dart';
import 'package:todo_mobx/data/repositories/profile_repository.dart';
import 'package:todo_mobx/data/repositories/register_repository.dart';
import 'package:todo_mobx/data/repositories/settings_repository.dart';
import 'package:todo_mobx/presentation/logic/settings/index.dart';
import 'package:todo_mobx/services/http_client/src/http_client.dart';

final locator = GetIt.instance;

void setup() {
  //core object
  locator.registerLazySingleton<HttpClient>(() => HttpClient());
  locator.registerLazySingleton<SecureStorage>(() => SecureStorage());
  locator.registerLazySingleton<MPreferences>(() => MPreferences());

  //end core objects

  //apis
  locator
      .registerLazySingleton<UserApi>(() => UserApi(locator.get<HttpClient>()));

  locator.registerLazySingleton<ProfileApi>(
      () => ProfileApi(locator.get<HttpClient>()));
  //end apis

  //repositories
  locator.registerLazySingleton(() =>
      LoginRepository(locator.get<UserApi>(), locator.get<SecureStorage>()));

  locator.registerLazySingleton<ProfileRepository>(() => ProfileRepository(
      locator.get<ProfileApi>(), locator.get<SecureStorage>()));

  locator.registerLazySingleton<RegisterRepository>(() =>
      RegisterRepository(locator.get<UserApi>(), locator.get<SecureStorage>()));

  locator.registerLazySingleton<SettingsRepository>(
      () => SettingsRepository(locator.get<MPreferences>()));

  //end repositories

  //state-management
  locator.registerLazySingleton<SettingsStore>(
      () => SettingsStore(locator.get<SettingsRepository>()));
}
