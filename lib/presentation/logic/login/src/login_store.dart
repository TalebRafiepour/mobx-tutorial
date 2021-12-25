import 'package:mobx/mobx.dart';
import 'package:todo_mobx/data/repositories/login_repository.dart';

part 'login_store.g.dart';

enum LoginState { authenticated, unAuthenticated,error }

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final LoginRepository _loginRepository;

  _LoginStore(this._loginRepository);

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  LoginState loginState = LoginState.unAuthenticated;

  @action
  Future<void> login() async {
    try {
      var isSuccess = await _loginRepository.loginUser(email, password);
      if(isSuccess) {
        loginState = LoginState.authenticated;
      }else {
        loginState = LoginState.unAuthenticated;
      }
    } catch (e, s) {
      print('error: $e');
      loginState = LoginState.error;
    }
  }
}
