import 'package:flutter/material.dart';
import 'package:mini_task_hub/auth/signup_screen.dart';
import 'package:mini_task_hub/widgets/custom_button.dart';
import 'package:mini_task_hub/widgets/custom_text_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 40, 50, 1),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(child: Image.asset("assets/images/dashboard.png"),),
            const SizedBox(
              height: 45,
            ),
            Text("Welcome Back!",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white
            ),),
            const SizedBox(
              height: 15,
            ),
            Text("Email Address",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.blueGrey
            ),),
            const SizedBox(
              height: 20,
            ),
            CustomTextFiled(
            controller: emailController,
            icon: Icons.perm_contact_cal,),

            const SizedBox(
              height: 35,
            ),
            Text("Password",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.blueGrey
            ),),
            const SizedBox(
              height: 20,
            ),
            CustomTextFiled(
            controller: passwordController,
            icon: Icons.lock_open,),

            const SizedBox(
              height: 50,
            ),
            CustomButton(
              label: 'Log In', onPressed: () {},
              backgroundColor: Colors.yellow.shade300,),

              const SizedBox(
              height: 30,
            ),
            Text("------------------------  Or continue with  -----------------------",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.blueGrey
            ),),
              const SizedBox(
              height: 30,
            ),
            CustomButton(
              label: 'Google', onPressed: () {},
              backgroundColor: Colors.transparent,
              textColor: Colors.white,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.blueGrey
            ),),

            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen()));
              },
              child: Text("Sign Up",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.yellow.shade300
            ),), ),
                ],
              )
          ],
        ),),
      ),
    );
  }
}