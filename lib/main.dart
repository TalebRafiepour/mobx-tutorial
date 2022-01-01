import 'package:flutter/material.dart';
import 'package:todo_mobx/presentation/screens/home/home_screen.dart';
import 'package:todo_mobx/presentation/screens/login/login_screen.dart';
import 'package:todo_mobx/presentation/screens/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
