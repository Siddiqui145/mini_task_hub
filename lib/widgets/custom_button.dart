import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
    this.width ,
    this.backgroundColor ,
    this.textColor ,
    this.borderRadius,
  });

  final String label;
  final VoidCallback ?onPressed;
  final double ?height;
  final double ?width;
  final Color ?backgroundColor;
  final Color ?textColor;
  final double ?borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
