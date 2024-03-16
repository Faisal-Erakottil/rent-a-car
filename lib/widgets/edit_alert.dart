import 'package:flutter/material.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class EditAlert extends StatelessWidget {
  final void Function() onEdit;
  const EditAlert({Key? key, required this.onEdit}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CustomColor.primary,
      title: const CustomText(
        textContent: "Confirm",
        fontWeight: FontWeight.bold,
        textColor: CustomColor.white,
        fontSize: 22,
      ),
      content: const CustomText(
        textContent: "Do you Want to Edit?",
        fontSize: 18,
      ),
      actions: <Widget>[
        customElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          label: "No",
          labelColor: CustomColor.black,
          backgroundColor: CustomColor.green,
        ),
        customElevatedButton(
          onPressed: onEdit,
          backgroundColor: CustomColor.green,
          label: "YES",
          labelColor: CustomColor.black,
        ),
      ],
    );
  }
}
