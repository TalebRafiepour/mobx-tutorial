import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx/data/repositories/login_repository.dart';

part 'login_store.g.dart';

enum LoginState { authenticated, unAuthenticated, error }

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  final LoginRepository _loginRepository;

  _LoginStore(this._loginRepository);

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  bool obscurePassword = true;

  @observable
  LoginState loginState = LoginState.unAuthenticated;

  Future<void> loginWithGoogle() async {
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();
    print('google signin user: ${user.toString()}');
    if(user != null) {
      //_loginRepository.loginWithGoogle(user);
    }
  }

  Future<void> loginWithFacebook() async {
    final result = await FacebookAuth.instance.login();
    final user = await FacebookAuth.instance.getUserData();
    print('facebook signin user: ${user.toString()}');
    if(user != null) {
      //_loginRepository.loginWithFacebook(user);
    }
  }

  @action
  Future<void> login() async {
    try {
      var isSuccess = await _loginRepository.loginUser(email, password);
      if (isSuccess) {
        loginState = LoginState.authenticated;
      } else {
        loginState = LoginState.unAuthenticated;
      }
    } catch (e, s) {
      print('error: $e');
      loginState = LoginState.error;
    }
  }
}
