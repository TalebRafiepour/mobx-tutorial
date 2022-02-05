import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx/core/app_theme/app_theme.dart';
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
                  decoration: InputDecoration(
                    prefixIcon:
                        AppTheme.textFieldPrefixIcon(const Text('Username')),
                    prefixIconConstraints: AppTheme.textFieldPrefixConstraint,
                  ),
                  onChanged: (value) {
                    _loginStore.email = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Observer(builder: (context) {
                  return TextField(
                    obscureText: _loginStore.obscurePassword,
                    decoration: InputDecoration(
                      prefixIcon:
                          AppTheme.textFieldPrefixIcon(const Text('Password')),
                      prefixIconConstraints: AppTheme.textFieldPrefixConstraint,
                      suffixIcon: IconButton(
                        onPressed: () {
                          _loginStore.obscurePassword =
                              !_loginStore.obscurePassword;
                        },
                        icon: _loginStore.obscurePassword
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                      ),
                    ),
                    onChanged: (value) {
                      _loginStore.password = value;
                    },
                  );
                }),
                const Spacer(
                  flex: 10,
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
                  child: ElevatedButton.icon(
                      icon: const Icon(Icons.login),
                      onPressed: () {
                        _loginStore.loginWithGoogle();
                      },
                      label: const Text('Login with Google')),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton.icon(
                      style: Theme.of(context)
                          .elevatedButtonTheme
                          .style
                          ?.copyWith(
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? MaterialStateProperty.all(Colors.white)
                                    : null,
                          ),
                      icon: Icon(
                        Icons.facebook_rounded,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : null,
                      ),
                      onPressed: () {
                        _loginStore.loginWithFacebook();
                      },
                      label: Text(
                        'Login with Facebook',
                        style: Theme.of(context).brightness == Brightness.dark
                            ? const TextStyle(color: Colors.black)
                            : null,
                      )),
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => const SignUpScreen()));
                      },
                      child: Text(
                        'SignUp',
                        style: Theme.of(context).brightness == Brightness.dark
                            ? const TextStyle(color: Colors.white)
                            : const TextStyle(color: Colors.black),
                      )),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
