// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';

//==========================================text class

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    textCapitalization = TextCapitalization.characters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 29, 29, 31),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        // Set keyboardType
      ),
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}

//==================================== text function
Widget textforms({
  required dynamic fieldname,
  dynamic controler,
  dynamic validater,
  required dynamic message,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextFormField(
    controller: controler,
    style: const TextStyle(color: Colors.white),
    keyboardType: keyboardType,
    decoration: InputDecoration(
      prefixIcon: const Icon(
        Icons.person,
        color: Colors.white,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 38, 38, 42),
      labelText: fieldname,
      errorText: validater ? message : null,
    ),
  );
}
