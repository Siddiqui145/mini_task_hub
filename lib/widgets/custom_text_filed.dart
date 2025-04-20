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
    return Container(
      height: widget.height ?? 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: _isFocused ? const Color(0xFF37474F) : const Color(0xFF263238),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _isFocused ? Colors.white : Colors.transparent,
          width: 1.2,
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ?? false,
        validator: widget.validator,
        focusNode: _focusNode,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          icon: widget.icon != null
              ? Icon(widget.icon, color: _isFocused ? Colors.white : Colors.grey[400])
              : null,
        ),
      ),
    );
  }
}