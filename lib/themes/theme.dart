import 'package:flutter/material.dart';
import 'package:mini_task_hub/themes/task_card_theme.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.indigo,
  scaffoldBackgroundColor: Colors.white70,

  extensions: [
    const TaskCardTheme(
      backgroundColor: Color(0xFFF3F4F6), // soft grey
      foregroundColor: Colors.black87,
      labelColor: Colors.black54,
      progressColor: Colors.indigo,
      completedTextColor: Colors.black54,
    ),
  ],

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.black,
    centerTitle: true
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),

    bodySmall: TextStyle(color: Colors.black, fontSize: 14,),
    bodyMedium: TextStyle(color: Colors.black, fontSize: 16,),
    bodyLarge: TextStyle(color: Colors.black, fontSize: 18,),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.black
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
    
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.indigo,
      foregroundColor: Colors.black87
    ),
  ),
  dialogTheme: AlertDialog(
    backgroundColor: Colors.grey.shade700,
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  scaffoldBackgroundColor: const Color(0xFF212832),
  extensions: [
    TaskCardTheme(
      backgroundColor: const Color.fromARGB(255, 89, 100, 115),
      foregroundColor: Colors.white70,
      labelColor: Colors.white60,
      progressColor: Colors.yellow.shade800,
      completedTextColor: Colors.black87,
    ),
  ],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.yellow.shade800,
    foregroundColor: Colors.white70
  ),
  iconTheme: IconThemeData(
    color: Colors.white70
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.yellow.shade800,
      foregroundColor: Colors.white70
    )
  ),
  dialogTheme: AlertDialog(
    backgroundColor: Colors.yellow.shade800,
  ),
);