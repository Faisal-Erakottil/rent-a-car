import 'package:flutter/material.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class DeleteAlert extends StatelessWidget {
  final void Function() onDelete;
  const DeleteAlert({Key? key, required this.onDelete}):super(key: key);

  @override
  Widget build(BuildContext context) {
     return AlertDialog(
        backgroundColor:CustomColor.primary,
        title: const CustomText(
          textContent: "Confirm",
          fontWeight: FontWeight.bold,
          textColor: CustomColor.white,
          fontSize: 22,
        ),
        content: const CustomText(
          textContent:
              "Are you sure you want to delete this customer?",
          fontSize: 18,
        ),
        actions: <Widget>[
          customElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: "CANCEL",
            labelColor: CustomColor.black,
            backgroundColor:CustomColor.green,
          ),
          customElevatedButton(
            onPressed:onDelete,
            backgroundColor:
                CustomColor.red,
            label: "DELETE",
            labelColor: CustomColor.black,
          ),
        ],
      );
    }
  }
