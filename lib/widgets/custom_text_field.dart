// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:main_project/widgets/customcolors.dart';

//==========================================text class

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final bool obscureText;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.onTap,
    textCapitalization = TextCapitalization.characters,
    required String fieldName,
    this.prefixIcon,
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
      onTap:onTap,
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}
//==================================== text function
Widget textforms({
  dynamic fieldname,
  dynamic controler,
  //dynamic validator,
  dynamic message,
  TextInputType keyboardType = TextInputType.text,
  Icon? prefixIcon,
  required TextEditingController controller,
  String? Function(String?)? validator,
  required bool validater,
}) {
  return TextFormField(
    controller: controler,
    style: const TextStyle(color: Colors.white),
    keyboardType: keyboardType,
    decoration: InputDecoration(
      prefixIcon: prefixIcon, iconColor: CustomColor.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: const Color.fromARGB(255, 38, 38, 42),
      labelText: fieldname,
      //errorText: validator ? message : null,
    ),
    validator: validator,
  );
}
