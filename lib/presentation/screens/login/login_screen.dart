import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx/data/providers/api/user_api.dart';
import 'package:todo_mobx/data/providers/storage/secure_storage.dart';
import 'package:todo_mobx/data/repositories/login_repository.dart';
import 'package:todo_mobx/presentation/logic/login/index.dart';
import 'package:todo_mobx/presentation/screens/home/home_screen.dart';
import 'package:todo_mobx/services/http_client/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginStore _loginStore;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  late ReactionDisposer _disposer;

  @override
  void initState() {
    _loginStore =
        LoginStore(LoginRepository(UserApi(HttpClient()), SecureStorage()));
    _disposer =
        reaction((_) => _loginStore.loginState, (LoginState loginState) {
      print('reaction loginState: $loginState');
      if (loginState == LoginState.authenticated) {
        //show success alert then go to home-screen
        _scaffoldKey.currentState
            ?.showSnackBar(const SnackBar(content: Text('Login Success')));
        Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        //just show an error alert to notify user that your data is incorrect
        _scaffoldKey.currentState
            ?.showSnackBar(const SnackBar(content: Text('Login Failed')));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: Scaffold(
          body: Column(
            children: [
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Email'),
                onChanged: (value) {
                  _loginStore.email = value;
                },
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password'),
                onChanged: (value) {
                  _loginStore.password = value;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    _loginStore.login();
                  },
                  child: const Text('Login')),
            ],
          ),
        ),
      ),
    );
  }
}
