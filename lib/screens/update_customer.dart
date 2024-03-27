// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/data_model/customer_db.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/custom_text_field.dart';
import 'package:main_project/widgets/customcolors.dart';

class UpdateCustomer extends StatefulWidget {
  final CustomerDetailsModel customerModel;
  const UpdateCustomer({super.key, required this.customerModel});

  @override
  State<UpdateCustomer> createState() => _UpdateCustomerState();
}

class _UpdateCustomerState extends State<UpdateCustomer> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _mobController = TextEditingController();
  var _licenseNumberController = TextEditingController();
  var _emailController = TextEditingController();
  var _PickUpController = TextEditingController();
  var _dropOffController = TextEditingController();
  var _meaterReadingController = TextEditingController();
  var _advanceController = TextEditingController();
  File? imgPath;
  String? Selectedimage;
  Widget space = const SizedBox(height: 10);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _mobController = TextEditingController();
    _licenseNumberController = TextEditingController();
    _emailController = TextEditingController();
    _PickUpController = TextEditingController();
    _dropOffController = TextEditingController();
    _meaterReadingController = TextEditingController();
    _advanceController = TextEditingController();
    Selectedimage = null;

    _nameController.text = widget.customerModel.customerName;
    _mobController.text = widget.customerModel.mobilNumber;
    _licenseNumberController.text = widget.customerModel.licenceNumber;
    _emailController.text = widget.customerModel.email;
    _PickUpController.text = widget.customerModel.pickUpDate;
    _dropOffController.text = widget.customerModel.dropOffDate;
    _meaterReadingController.text = widget.customerModel.reading;
    _advanceController.text = widget.customerModel.advance;
    Selectedimage = widget.customerModel.CustomerImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: CustomText(
            text: 'Customer Details',
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: CustomColor.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextField(
                  labelText: 'Name',
                  fieldName: 'Name',
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                ),
                space,
                CustomTextField(
                  labelText: 'Mobile number',
                  fieldName: 'Mobile number',
                  keyboardType: TextInputType.phone,
                  controller: _mobController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a mobile number';
                    }
                    if (value.length != 10) {
                      return 'Mobile number must be 10 digits';
                    }
                    return null;
                  },
                ),
                space,
                CustomTextField(
                  labelText: 'Email Id',
                  fieldName: 'Email Id',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Invalid email address';
                    }
                    return null;
                  },
                ),
                space,
                CustomTextField(
                  labelText: 'License Number',
                  fieldName: 'License Number',
                  controller: _licenseNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter a licence number';
                    }
                    if (!RegExp(r'^[A-Z]{2}\d{2}\d{4}\d{7}$').hasMatch(value)) {
                      return 'Invalid licence number';
                    }
                    return null;
                  },
                ),
                space,
                CustomTextField(
                  labelText: 'Number of days',
                  fieldName: 'Number of days',
                  controller: _PickUpController,
                  keyboardType: TextInputType.number,
                ),
                space,
                if (Selectedimage != null)
                  SizedBox(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(Selectedimage!),
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: pickImageFromGallery,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                space,
                customButton(
                  onPressed: pickImageFromGallery,
                  label: 'ADD IMAGE',
                ),
                space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: const Color.fromARGB(255, 10, 47, 39),
                        fixedSize: const Size(300, 30),
                      ),
                      onPressed: () async {
                        widget.customerModel.customerName =
                            _nameController.text;
                        widget.customerModel.mobilNumber = _mobController.text;
                        widget.customerModel.licenceNumber =
                            _licenseNumberController.text;
                        widget.customerModel.email = _emailController.text;
                        widget.customerModel.pickUpDate =
                            _PickUpController.text;
                        widget.customerModel.dropOffDate =
                            _dropOffController.text;
                        widget.customerModel.reading =
                            _meaterReadingController.text;
                        widget.customerModel.advance = _advanceController.text;
                        widget.customerModel.CustomerImage =
                            Selectedimage ?? "";
                        await widget.customerModel.save();

                        Navigator.pop(context);
                      },
                      child: const Text(
                        'UPDATE',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        // imgPath = File(returnedImage.path);
        Selectedimage = returnedImage.path;
      });
    }
  }
}
