import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_mobx/data/repositories/register_repository.dart';
import 'package:todo_mobx/locator.dart';
import 'package:todo_mobx/presentation/logic/singup/index.dart';
import 'package:todo_mobx/presentation/screens/home/home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final SignUpStore _signUpStore =
      SignUpStore(locator.get<RegisterRepository>());
  late final ReactionDisposer _disposer;

  @override
  void initState() {
    _disposer = reaction((_) => _signUpStore.signUpState, _signupReaction);
    super.initState();
  }

  void _signupReaction(SignUpState signUpState) {
    signUpState.maybeWhen(
        orElse: () => null,
        registered: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false);
        },
        notRegistered: (message) {
          _formKey.currentState!.reset();
          _scaffoldKey.currentState
              ?.showSnackBar(SnackBar(content: Text(message)));
        });
  }

  @override
  void dispose() {
    _disposer.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SingUp'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => _signUpStore.email = value,
                  validator: _signUpStore.emailValidator,
                  onSaved: _signUpStore.saveEmail,
                  decoration: const InputDecoration(label: Text('Email')),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => _signUpStore.name = value,
                  validator: _signUpStore.nameValidator,
                  onSaved: _signUpStore.saveName,
                  decoration: const InputDecoration(label: Text('Name')),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onChanged: (value) => _signUpStore.age = value,
                  validator: _signUpStore.ageValidator,
                  onSaved: _signUpStore.saveAge,
                  decoration: const InputDecoration(label: Text('Age')),
                ),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  onChanged: (value) => _signUpStore.password = value,
                  validator: _signUpStore.passwordValidator,
                  onSaved: _signUpStore.savePassword,
                  decoration: const InputDecoration(label: Text('Password')),
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  validator: _signUpStore.repeatPasswordValidator,
                  decoration:
                      const InputDecoration(label: Text('Repeat Password')),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: Observer(builder: (_) {
                    return _signUpStore.signUpState.maybeWhen(orElse: () {
                      return ElevatedButton.icon(
                        onPressed: _saveForm,
                        icon: const Icon(Icons.login),
                        label: const Text('Register'),
                      );
                    }, loading: () {
                      return const Center(child: CircularProgressIndicator());
                    });
                  }),
                ),
              ]
                  .expand((element) => [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: element,
                        )
                      ])
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _signUpStore.registerUser();
    }
  }
}
