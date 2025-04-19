import 'package:flutter/material.dart';
import 'package:mini_task_hub/auth/login_screen.dart';
import 'package:mini_task_hub/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do App',
      theme: ThemeData(
      ),
      //home: SplashScreen()
      home: LoginScreen(),
    );
  }
}