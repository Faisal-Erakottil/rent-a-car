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
        text: "Confirm",
        fontWeight: FontWeight.bold,
        size: 22,
      ),
      content: const CustomText(
        text: "Do you Want to Edit?",
        size: 18,
      ),
      actions: <Widget>[
        customButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          label: "No",
          labelColor: CustomColor.black,
          backgroundColor: CustomColor.green,
        ),
        customButton(
          onPressed: onEdit,
          backgroundColor: CustomColor.green,
          label: "YES",
          labelColor: CustomColor.black,
        ),
      ],
    );
  }
}
