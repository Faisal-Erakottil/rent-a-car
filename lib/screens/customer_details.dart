// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/customer.dart';
import 'package:main_project/screens/search_screen.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/custom_text_field.dart';
import 'package:main_project/widgets/customcolors.dart';
import 'package:main_project/widgets/image_selection.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _dayCountController = TextEditingController();
  final _meaterReadingController = TextEditingController();
  final _advanceController = TextEditingController();
  String imgPath = "";
  Widget space = const SizedBox(height: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        title: const Padding(
          padding: EdgeInsets.only(left: 60.0),
          child: CustomText(
            textContent: "Customer Details",
            textColor: CustomColor.white,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ImageSelectionWidget(
                  onImageSelected:
                      (File? pickedImage, String? pickedImagePath) {
                    imgPath = pickedImagePath!;
                    //print('Image selected: $pickedImage, Image path: $pickedImagePath');
                  },
                ),
                //========================================================Name
                CustomTextField(
                  controller: _nameController,
                  fieldName: "Name",
                  labelText: "Name",
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                  prefixIcon: Icons.abc,
                ),
                space,
                //===============================================Mobile Number
                CustomTextField(
                  labelText: "Mobile Number",
                  fieldName: 'Mobile Number',
                  controller: _mobController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Mobile Number is required";
                    }
                    return null;
                  },
                  prefixIcon: Icons.phone_iphone,
                ),
                space,
                //================================================License Number
                CustomTextField(
                  labelText: "License Number",
                  fieldName: "License Number",
                  controller: _licenseNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "License Number is required";
                    }
                    return null;
                  },
                  prefixIcon: Icons.badge,
                ),
                space,
                //======================================================Email ID
                CustomTextField(
                  labelText: "Email ID",
                  fieldName: "Email ID",
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email ID is required";
                    }
                    return null;
                  },
                  prefixIcon: Icons.email,
                ),
                space,
                //================================================Number of Days
                CustomTextField(
                  labelText: "Number of Days",
                  fieldName: "Number of Days",
                  controller: _dayCountController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Number of days is required";
                    }
                    return null;
                  },
                  prefixIcon: Icons.today,
                ),
                space,
                //================================================Meater Reading
                CustomTextField(
                  labelText: "Meater Reading",
                  fieldName: "Meater Reading",
                  controller: _meaterReadingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Meater reading is required";
                    }
                    return null;
                  },
                  prefixIcon: Icons.track_changes,
                ),
                space,
                //===============================================Advance amount
                CustomTextField(
                  labelText: "Advance",
                  fieldName: "Advance",
                  controller: _advanceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Advance is required";
                    }
                    return null;
                  },
                  prefixIcon: Icons.currency_rupee,
                ),
                space,
                //==========================================Save Details Button
                customElevatedButton(
                  label: "Save Detail",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveCustomerDetail();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveCustomerDetail() {
    final name = _nameController.text.trim();
    final mobNumber = _mobController.text.trim();
    final licenseNumber = _licenseNumberController.text.trim();
    final email = _emailController.text.trim();
    final days = _dayCountController.text.trim();
    final meaterReading = _meaterReadingController.text.trim();
    final advance = _advanceController.text.trim();
    //final imagePath = imgPath;

    if (name.isEmpty ||
        mobNumber.isEmpty ||
        licenseNumber.isEmpty ||
        email.isEmpty ||
        days.isEmpty ||
        meaterReading.isEmpty ||
        advance.isEmpty ||
        imgPath.isEmpty) {
      return;
    }

    final customer = CustomerDetailsModel(
      customerName: name,
      mobilNumber: mobNumber,
      LicenceNumber: licenseNumber,
      Email: email,
      days: days,
      reading: meaterReading,
      advance: advance,
      CustomerImage: imgPath,
    );

    addcustomer(customer);

    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Customer()));
  }
}
