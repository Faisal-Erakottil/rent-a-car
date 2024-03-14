
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/custom_text_field.dart';
import 'package:main_project/widgets/customcolors.dart';
import 'package:main_project/widgets/image_selection.dart';

class CustomerDetails extends StatefulWidget {
  final CustomerDetailsModel? customer;

  const CustomerDetails({Key? key, this.customer}) : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobController = TextEditingController();
  final TextEditingController _licenseNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dayCountController = TextEditingController();
  final TextEditingController _meaterReadingController = TextEditingController();
  final TextEditingController _advanceController = TextEditingController();
  String _imgPath = "";

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      _nameController.text = widget.customer!.customerName;
      _mobController.text = widget.customer!.mobilNumber;
      _licenseNumberController.text = widget.customer!.LicenceNumber;
      _emailController.text = widget.customer!.Email;
      _dayCountController.text = widget.customer!.days;
      _meaterReadingController.text = widget.customer!.reading;
      _advanceController.text = widget.customer!.advance;
      _imgPath = widget.customer!.CustomerImage;
    }
  }

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
          child: Column(
            children: [
              ImageSelectionWidget(
                onImageSelected: (File? pickedImage, String? pickedImagePath) {
                  setState(() {
                    _imgPath = pickedImagePath ?? "";
                  });
                },
                initialImagePath: _imgPath.isNotEmpty ? _imgPath : null,
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
                }, prefixIcon: Icons.abc,
              ),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
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
                }, prefixIcon: Icons.email,
              ),
              const SizedBox(height: 10),
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
                }, prefixIcon: Icons.today,
              ),
              const SizedBox(height: 10),
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
                },prefixIcon: Icons.track_changes,
              ),
              const SizedBox(height: 10),
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
                }, prefixIcon: Icons.currency_rupee,
              ),
              const SizedBox(height: 10),
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

    if (name.isEmpty ||
        mobNumber.isEmpty ||
        licenseNumber.isEmpty ||
        email.isEmpty ||
        days.isEmpty ||
        meaterReading.isEmpty ||
        advance.isEmpty 
        // || _imgPath.isEmpty,
        )
        {
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
      CustomerImage: _imgPath,
    );

    if (widget.customer != null) {
      customer.id = widget.customer!.key;
      UpdateCustomer(customer);
    } else {
      addcustomer(customer);
    }

    Navigator.of(context).pop();
  }
}
