import 'package:flutter/material.dart';
import 'package:mini_task_hub/auth/auth_service.dart';
import 'package:mini_task_hub/auth/signup_screen.dart';
import 'package:mini_task_hub/dashboard/dashboard_screen.dart';
import 'package:mini_task_hub/widgets/custom_button.dart';
import 'package:mini_task_hub/widgets/custom_messages.dart';
import 'package:mini_task_hub/widgets/custom_text_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (!_formKey.currentState!.validate()) {
    return;
    }

    if(email.isEmpty || password.isEmpty){
      showErrorMessage(context, "Email & Password both are required!");
      return;
    }

    if(password.length < 6){
      showErrorMessage(context, "Your Password is at least 6 characters long!");
    }

    try {
      await _authService.loginWithEmailAndPassword(
        email,password);

        if(!mounted) return;

        showSuccessMessage(context, "User Successfully logged In!");
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => DashboardScreen()));
    }
    catch (e){
      showErrorMessage(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
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
                style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(
                  height: 15,
                ),
                Text("Email Address",
                style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                controller: emailController,
                icon: Icons.perm_contact_cal,
                hintText: "Email",
                validator: (value) {
                      if (value == null || value.isEmpty) return 'Email cannot be empty';
                      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                        return "Enter a valid email!";
                      }
                      return null;
                    },),
            
                const SizedBox(
                  height: 35,
                ),
                Text("Password",
                style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                controller: passwordController,
                hintText: "Password",
                icon: Icons.lock_open,
                isPassword: true),
            
                const SizedBox(
                  height: 50,
                ),
                CustomButton(
                  label: 'Log In', onPressed: login,
                  ),
            
                  const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text("Or continue with",
                  style: Theme.of(context).textTheme.bodyMedium),
                ),
                  const SizedBox(
                  height: 30,
                ),
                CustomButton(
                  label: 'Google', onPressed: () {},
                  backgroundColor: Colors.transparent,
                  ),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",
                style: Theme.of(context).textTheme.bodyMedium),
            
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignupScreen()));
                  },
                  child: Text("Sign Up",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.yellow.shade300
                  )), ),
                    ],
                  )
              ],
            ),
          ),),
        ),
      ),
    );
  }
}