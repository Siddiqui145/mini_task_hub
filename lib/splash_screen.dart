import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Future.delayed(
      const Duration(seconds: 3), () async {
        if (context.mounted){

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