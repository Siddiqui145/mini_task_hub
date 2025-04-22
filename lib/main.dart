import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_task_hub/providers/cubit_theme.dart';
import 'package:mini_task_hub/splash_screen.dart';
import 'package:mini_task_hub/themes/theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider(
    create: (_) => CubitTheme(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitTheme, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Flutter To-Do App',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      }
    );
  }
}