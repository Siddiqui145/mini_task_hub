import 'package:flutter/material.dart';

class CustomTextFiled extends StatefulWidget {
  const CustomTextFiled({
    super.key,
    this.height,
    required this.controller,
    this.icon,
    this.isPassword
    });

    final double ?height;
    final TextEditingController controller;
    final IconData  ?icon;
    final bool ?isPassword;

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: widget.height ?? 45,
      padding: EdgeInsets.symmetric(
        horizontal: 15
      ),
      decoration: BoxDecoration(
        color: Color.fromRGBO(69, 90, 100, 1),
        borderRadius: BorderRadius.circular(8)
      ),

      child: Center(
        child: TextField(
          controller: widget.controller,
          obscureText: widget.isPassword ?? false,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white
          ),
          
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            icon: widget.icon != null ? Icon(widget.icon) : null,
            iconColor: Colors.white
          ),
          
        
        
        ),
      ),
    );
  }
}