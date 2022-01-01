import 'package:flutter/material.dart';
import 'package:todo_mobx/data/providers/storage/secure_storage.dart';
import 'package:todo_mobx/presentation/screens/home/home_screen.dart';
import 'package:todo_mobx/presentation/screens/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      SecureStorage().isUserLogin().then((isUserLogin) {
        if (isUserLogin) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const HomeScreen()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => const LoginScreen()));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              'Welcome To TodoApp',
              style: TextStyle(fontSize: 32),
            ),
            SizedBox(
              height: 60,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
