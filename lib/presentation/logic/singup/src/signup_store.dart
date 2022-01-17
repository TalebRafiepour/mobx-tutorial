import 'package:mobx/mobx.dart';
import 'package:todo_mobx/data/repositories/register_repository.dart';
import 'package:todo_mobx/presentation/logic/singup/src/signup_state.dart';
import 'package:validators/validators.dart';

part 'signup_store.g.dart';

class SignUpStore = _SignUpStore with _$SignUpStore;

abstract class _SignUpStore with Store {
  final RegisterRepository _registerRepository;

  _SignUpStore(this._registerRepository);

  @observable
  String name = '';
  @observable
  String email = '';
  @observable
  String password = '';
  @observable
  String age = '';

  @observable
  SignUpState signUpState = const SignUpState.initial();

  String? emailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return 'You must write your email';
    } else if (isEmail(email)) {
      return null;
    } else {
      return 'Your email address is not valid';
    }
  }

  @action
  void saveEmail(String? email) {
    if (email == null || email.isEmpty) return;
    this.email = email;
  }

  String? nameValidator(String? name) {
    if (name == null || name.isEmpty) {
      return 'You must write your name';
    } else if (name.length > 3) {
      return null;
    } else {
      return 'Your name must be more than 3 characters';
    }
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'You must write your password';
    } else if (password.length > 7) {
      return null;
    } else {
      return 'Your password is not strong!';
    }
  }

  String? repeatPasswordValidator(String? repeatPassword) {
    if (repeatPassword == null || repeatPassword.isEmpty) {
      return 'You must repeat your password';
    } else if (repeatPassword == password) {
      return null;
    } else {
      return 'Your repeat password must be same as password!';
    }
  }

  @action
  void savePassword(String? password) {
    if (password == null || password.isEmpty) return;
    this.password = password;
  }

  @action
  void saveName(String? name) {
    if (name == null || name.isEmpty) return;
    this.name = name;
  }

  String? ageValidator(String? age) {
    if (age == null || age.isEmpty) {
      return 'You must write your age';
    } else if (isInt(age)) {
      return null;
    } else {
      return 'You must write numbers for your age, not text!';
    }
  }

  @action
  void saveAge(String? age) {
    if (age == null || age.isEmpty) return;
    this.age = age;
  }

  @action
  Future<void> registerUser() async {
    try {
      signUpState = const SignUpState.loading();
      await _registerRepository.registerUser(name, email, password, age);
      signUpState = const SignUpState.registered();
    } catch (e, s) {
      signUpState = const SignUpState.notRegistered('Error in registration!');
    }
  }
}
