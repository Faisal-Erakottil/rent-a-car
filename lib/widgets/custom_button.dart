import 'package:flutter/material.dart';

Widget customElevatedButton({
  required VoidCallback onPressed,
  required String label,
  Color? backgroundColor,
  Color? labelColor,
  double width = 200,
  double height = 5,
  required Icon icon,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: backgroundColor,
      fixedSize: Size(width, height),
    ),
    onPressed: onPressed,
    child: Text(
      label,
      style: TextStyle(color: labelColor),
    ),
  );
}

//====================custom Dropdown Field
Widget customDropdownField({
  required String labelText,
  required String hintText,
  required String? value,
  required List<String> items,
  required Function(String?) onChanged,
  required Widget prefixIcon,
}) {
  return DropdownButtonFormField<String>(
    dropdownColor: const Color.fromARGB(255, 29, 29, 31),
    value: value,
    items: items.map((String item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(
          item,
          style: const TextStyle(color: Colors.white),
        ),
      );
    }).toList(),
    onChanged: onChanged,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black),
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.white),
      fillColor: Colors.blue,
      prefixIcon: prefixIcon,
      prefixIconColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Value is empty';
      } else {
        return null;
      }
    },
  );
}
