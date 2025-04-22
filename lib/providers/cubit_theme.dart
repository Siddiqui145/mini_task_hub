import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CubitTheme extends Cubit<ThemeMode>{
  CubitTheme(): super(ThemeMode.light);

  void toggleTheme(bool isDark){
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  void setTheme(ThemeMode themeMode){
    emit(themeMode);
  }
}