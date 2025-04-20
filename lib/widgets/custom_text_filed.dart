import 'package:flutter/material.dart';

class CustomTextFiled extends StatefulWidget {
  const CustomTextFiled({
    super.key,
    this.height,
    required this.controller,
    this.icon,
    this.isPassword,
    this.validator,
    this.hintText,
  });

  final double? height;
  final TextEditingController controller;
  final IconData? icon;
  final bool? isPassword;
  final String? Function(String?)? validator;
  final String? hintText;

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 60,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ?? false,
        validator: widget.validator,
        focusNode: _focusNode,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: _isFocused ? const Color(0xFF37474F) : const Color(0xFF263238),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          prefixIcon: widget.icon != null
              ? Icon(widget.icon, color: _isFocused ? Colors.white : Colors.grey[400])
              : null,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white, width: 1.2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red, width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}