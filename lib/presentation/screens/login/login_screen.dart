import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx/data/repositories/login_repository.dart';
import 'package:todo_mobx/locator.dart';
import 'package:todo_mobx/presentation/logic/login/index.dart';
import 'package:todo_mobx/presentation/screens/home/home_screen.dart';
import 'package:todo_mobx/presentation/screens/signup/singup.dart';

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
    _loginStore = LoginStore(locator.get<LoginRepository>());
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
          appBar: AppBar(
            title: const Text('Login'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
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
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                      onPressed: () {
                        _loginStore.login();
                      },
                      child: const Text('Login')),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const SignUpScreen()));
                      },
                      child: const Text(
                        'SignUp',
                        style: TextStyle(color: Colors.black),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
