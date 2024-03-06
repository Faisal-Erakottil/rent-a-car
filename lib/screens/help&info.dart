// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class HelpAndInfo extends StatelessWidget {
  const HelpAndInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 29, 31),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.all(88.0),
          child: CustomText(
            textContent: "Help & info",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
         iconTheme: const IconThemeData(
          color: CustomColor.white,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: CustomText(
            textContent: "Welcome to the Help Center! We're here "
                "\nto guide you through the features and "
                "functionalities of our application. Whether "
                "you're a new user or an experienced pro, we "
                "have resources to help you get the most out "
                "of Rent a Car.\n"
                "\n"
                "This page provides answers to frequently "
                "asked questions, detailed instructions for "
                "using specific features, and troubleshooting "
                "tips. You can also search our knowledge "
                "base or contact our support team directly if"
                "you need further assistance.\n"
                "\n"
                "Remember, we're always happy to help! So don't \n"
                "hesitate to reach out if you have any questions or\n"
                "need a helping hand.\n",
            textColor: Colors.blue,
            fontSize: 16),
      ),
    );
  }
}
