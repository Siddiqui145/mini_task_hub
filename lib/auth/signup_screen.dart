import 'package:flutter/material.dart';
import 'package:mini_task_hub/auth/login_screen.dart';
import 'package:mini_task_hub/widgets/custom_button.dart';
import 'package:mini_task_hub/widgets/custom_text_filed.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isChecked = false;

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
            Text("Create your account",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white
            ),),
            const SizedBox(
              height: 15,
            ),

            Text("Full Name",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.blueGrey
            ),),
            const SizedBox(
              height: 20,
            ),
            CustomTextFiled(
            controller: emailController,
            icon: Icons.person_2_rounded,),
            const SizedBox(
              height: 25,
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
              height: 25,
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
              height: 15,
            ),
            Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    IconButton(
      onPressed: () {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      icon: Icon(_isChecked ? Icons.check_box : Icons.check_box_outline_blank,
      color: Colors.yellow.shade300,),
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: "I have read & agreed to DayTask ",
                  style: TextStyle(color: Colors.blueGrey),
                ),
                TextSpan(
                  text: "Privacy Policy, Terms & Conditions",
                  style: TextStyle(color: Colors.yellow.shade300),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ],
),


            const SizedBox(
              height: 25,
            ),
            CustomButton(
              label: 'Sign Up', onPressed: () {},
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
                  Text("Already have an account?",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.blueGrey
            ),),

            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text("Log In",
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