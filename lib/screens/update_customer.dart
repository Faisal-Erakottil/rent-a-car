// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, prefer_const_constructors, avoid_print

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
    _PickUpController = TextEditingController();
    _dropOffController = TextEditingController();
    _meaterReadingController = TextEditingController();
    _advanceController = TextEditingController();
    Selectedimage = null;

    _nameController.text = widget.customerModel.customerName;
    _mobController.text = widget.customerModel.mobilNumber;
    _licenseNumberController.text = widget.customerModel.licenceNumber;
    _PickUpController.text = widget.customerModel.pickUpDate;
    _dropOffController.text = widget.customerModel.dropOffDate;
    _meaterReadingController.text = widget.customerModel.reading;
    _advanceController.text = widget.customerModel.advance;
    Selectedimage = widget.customerModel.CustomerImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        centerTitle: true,
        title: CustomText(
          text: 'Update Customer',
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: CustomColor.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              //==================================image
              children: [                
                if (Selectedimage != null)
                  SizedBox(
                    height: 170,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage: FileImage(File(Selectedimage!)),
                          ),
                          onTap: () {
                            pickImageFromGallery();
                          },
                        ),
                      ],
                    ),
                  ),
                space,
                //===================================Name
                CustomTextField(
                  labelText: 'Name',
                  fieldName: 'Name',
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Customer Name';
                    }
                    return null;
                  },
                ),
                space,
                //===================================Mobile Number
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
                //===================================License Number
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
                //===================================Pick up Date
                CustomTextField(
                  labelText: 'Pick Up Date',
                  fieldName: 'Pick Up Date',
                  controller: _PickUpController,
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'pick up date is empty';
                    }
                    return null;
                  },
                ),
                space,
                //===================================Drop off date
                CustomTextField(
                  controller: _dropOffController,
                  labelText: "Drop off Date",
                  fieldName: "Drop off Date",
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Drop off date is empty';
                    }
                    return null;
                  },
                ),
                space,
                //===================================Meater reading
                CustomTextField(
                  controller: _meaterReadingController,
                  labelText: "Meater Reading",
                  fieldName: "Meater Reading",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Meater reading is Empty';
                    }
                    return null;
                  },
                ),
                space,
                //===================================Advance amount
                CustomTextField(
                  controller: _advanceController,
                  labelText: "Advance ",
                  fieldName: "Advance",
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Advance amount';
                    }
                    return null;
                  },
                ),
                space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //===================================update button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: CustomColor.blue,
                        fixedSize: Size(200, 30),
                      ),
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          widget.customerModel.customerName =
                              _nameController.text;

                          widget.customerModel.mobilNumber =
                              _mobController.text;

                          widget.customerModel.licenceNumber =
                              _licenseNumberController.text;

                          widget.customerModel.pickUpDate =
                              _PickUpController.text;

                          widget.customerModel.dropOffDate =
                              _dropOffController.text;

                          widget.customerModel.reading =
                              _meaterReadingController.text;

                          widget.customerModel.advance =
                              _advanceController.text;

                          widget.customerModel.CustomerImage =
                              Selectedimage ?? "";

                          await widget.customerModel.save();
                        }
                        Navigator.pop(context);
                      },
                      child: const CustomText(
                        text: 'UPDATE',
                        color: CustomColor.black,
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
        Selectedimage = returnedImage.path;
      });
    }
  }
}
