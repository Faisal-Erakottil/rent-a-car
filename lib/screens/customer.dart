// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:main_project/screens/customerList.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class Customer extends StatefulWidget {
  const Customer({Key? key}) : super(key: key);

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        title: const Padding(
          padding: EdgeInsets.only(left: 75),
          child: CustomText(
            textContent: "Customer List",
            textColor: CustomColor.white,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: CustomColor.primary,
      body: const CustomerList(),
    );
  }
}
