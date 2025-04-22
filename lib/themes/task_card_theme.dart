// task_card_theme.dart
import 'package:flutter/material.dart';

@immutable
class TaskCardTheme extends ThemeExtension<TaskCardTheme> {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color labelColor;
  final Color progressColor;
  final Color completedTextColor;

  const TaskCardTheme({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.labelColor,
    required this.progressColor,
    required this.completedTextColor,
  });

  @override
  TaskCardTheme copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? labelColor,
    Color? progressColor,
    Color? completedTextColor,
  }) {
    return TaskCardTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      labelColor: labelColor ?? this.labelColor,
      progressColor: progressColor ?? this.progressColor,
      completedTextColor: completedTextColor ?? this.completedTextColor,
    );
  }

  @override
  TaskCardTheme lerp(ThemeExtension<TaskCardTheme>? other, double t) {
    if (other is! TaskCardTheme) return this;
    return TaskCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t)!,
      labelColor: Color.lerp(labelColor, other.labelColor, t)!,
      progressColor: Color.lerp(progressColor, other.progressColor, t)!,
      completedTextColor: Color.lerp(completedTextColor, other.completedTextColor, t)!,
    );
  }
}
