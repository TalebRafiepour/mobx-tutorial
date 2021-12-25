import 'package:todo_mobx/data/providers/api/user_api.dart';

class LoginRepository {
  final UserApi _userApi;

  LoginRepository(this._userApi);

  Future<bool> loginUser(String email, String password) {
    return _userApi.login(email, password);
  }
}
