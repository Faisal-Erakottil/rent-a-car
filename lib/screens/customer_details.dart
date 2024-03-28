// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_project/data_model/customer_db.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/customer.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/custom_text_field.dart';
import 'package:main_project/widgets/customcolors.dart';
import 'package:main_project/widgets/image_selection.dart';

class CustomerData extends StatefulWidget {
  // final CustomerDetailsModel customer;
  const CustomerData({
    super.key,
  });

  @override
  State<CustomerData> createState() => _CustomerDataState();
}

class _CustomerDataState extends State<CustomerData> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _pickupController = TextEditingController();
  final _dropOffController = TextEditingController();
  final _meaterReadingController = TextEditingController();
  final _advanceController = TextEditingController();
  String? selectedImage;
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
            text: "Customer Details",
            size: 20,
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
                  },
                ),
                //==========================================================Name
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
                //=================================================Mobile Number
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
                //================================================ pick Up Date
                CustomTextField(
                    labelText: "Pick Up Date",
                    fieldName: "Pick Up Date",
                    controller: _pickupController,
                    onTap: () async {
                      DateTime currentDate = DateTime.now();
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: currentDate,
                        firstDate: currentDate,
                        lastDate: DateTime(2050),
                      );
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyy').format(pickedDate);
                        _pickupController.text = formattedDate;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Pick Up a Date";
                      }
                      return null;
                    },
                    prefixIcon: Icons.calendar_today_rounded),
                space,
                //=================================================Drop Off Date
                CustomTextField(
                  labelText: "Drop off Date",
                  fieldName: "Drop off Date",
                  controller: _dropOffController,
                  onTap: () async {
                    DateTime currentDate = DateTime.now();
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: currentDate,
                      firstDate: currentDate,
                      lastDate: DateTime(2050),
                    );
                    if (pickedDate != null) {
                      _dropOffController.text =
                          DateFormat('dd-MM-yyy').format(pickedDate);
                      _formKey.currentState?.validate();
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Pick a drop off Date";
                    }
                    return null;
                  },
                  prefixIcon: Icons.calendar_today_rounded,
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
                customButton(
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
    final pickUpDate = _pickupController.text.trim();
    final dropOffDate = _dropOffController.text.trim();
    final meaterReading = _meaterReadingController.text.trim();
    final advance = _advanceController.text.trim();
    if (name.isEmpty ||
        mobNumber.isEmpty ||
        licenseNumber.isEmpty ||
        email.isEmpty ||
        pickUpDate.isEmpty ||
        dropOffDate.isEmpty ||
        meaterReading.isEmpty ||
        advance.isEmpty ||
        imgPath.isEmpty) {
      return;
    }
    final customer = CustomerDetailsModel(
      customerName: name,
      mobilNumber: mobNumber,
      licenceNumber: licenseNumber,
      email: email,
      pickUpDate: pickUpDate,
      dropOffDate: dropOffDate,
      reading: meaterReading,
      advance: advance,
      CustomerImage: imgPath,
    );
    addcustomer(customer);
    Navigator.pop(context);
    // Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => const Customer()));
  }
}
