import 'package:get_it/get_it.dart';
import 'package:todo_mobx/data/providers/api/profile_api.dart';
import 'package:todo_mobx/data/providers/api/user_api.dart';
import 'package:todo_mobx/data/providers/storage/secure_storage.dart';
import 'package:todo_mobx/data/repositories/login_repository.dart';
import 'package:todo_mobx/data/repositories/profile_repository.dart';
import 'package:todo_mobx/data/repositories/register_repository.dart';
import 'package:todo_mobx/services/http_client/src/http_client.dart';

final locator = GetIt.instance;

void setup() {
  //core object
  locator.registerLazySingleton<HttpClient>(() => HttpClient());
  locator.registerLazySingleton<SecureStorage>(() => SecureStorage());

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

  //end repositories
}
