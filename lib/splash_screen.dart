import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_task_hub/auth/login_screen.dart';
import 'package:mini_task_hub/dashboard/dashboard_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Future.delayed(
      const Duration(seconds: 4), () async {
        if (context.mounted){
          final user = FirebaseAuth.instance.currentUser;
          if (user != null){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardScreen()));
          }
          else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
          }
        }
      }
    );
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/Animation.gif",
        fit: BoxFit.scaleDown,),
      ),
    );
  }
}