// ignore_for_file: avoid_web_libraries_in_flutter, unused_import, duplicate_import, unused_element, prefer_const_literals_to_create_immutables, prefer_const_constructors

//import 'dart:html' hide File; // Hide File from dart:html
import 'dart:io' as io; // Import dart:io with a prefix to disambiguate
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/customer_db.dart';
import 'package:main_project/data_model/vehicle_db.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/customer.dart';
import 'package:main_project/screens/pages/home_screen.dart';
import 'package:main_project/screens/vehicle/rentout_cars.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class CollectedData extends StatefulWidget {
  //final VehicleDetailsModel vehicleDetails;
  final CustomerDetailsModel customerDetails;

  const CollectedData({
    Key? key,
    required this.customerDetails,
  }) : super(key: key);

  @override
  State<CollectedData> createState() => _CollectedDataState();
}

class _CollectedDataState extends State<CollectedData> {
  var nameController = TextEditingController();
  var mobNoController = TextEditingController();
  var licenseNoController = TextEditingController();
  var pickupController = TextEditingController();
  var dropOffController = TextEditingController();
  var meaterController = TextEditingController();
  var advanceController = TextEditingController();

  String? selectedFuel;
  String? selectedSeat;
  File? selectedImage;

  Widget _buildSelectedImage() {
    return CircleAvatar(
      radius: 110,
      backgroundColor: Colors.white,
      backgroundImage: widget.customerDetails.CustomerImage.isNotEmpty
          ? FileImage(io.File(widget.customerDetails.CustomerImage))
          : null,
      child: widget.customerDetails.CustomerImage.isEmpty
          ? Icon(
              Icons.person,
              size: 100,
              color: CustomColor.primary,
            )
          : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColor.black,
        title: const CustomText(
          text: "Full Details",
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: CustomColor.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(right: 50, left: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: _buildSelectedImage(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    height: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //===================================customer Name
                            children: [
                              const CustomText(
                                text: "Name",
                                fontWeight: FontWeight.w600,
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.customerDetails.customerName,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        //=======================================mobile Number
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const CustomText(
                                text: "Mobile No",
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.customerDetails.mobilNumber,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        //======================================License number
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "License No",
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.customerDetails.licenceNumber,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        //========================================pick up date
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Pick up date ",
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.customerDetails.pickUpDate,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        //=======================================Drop Off date
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Drop off date ",
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.customerDetails.dropOffDate,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        //======================================meater reading
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Meater reading",
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.customerDetails.reading,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        //============================================= Advance
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Advance ",
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.customerDetails.advance,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        //============================================== Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: CustomColor.primary,
                                      title: const CustomText(
                                        text: "Confirm",
                                        fontWeight: FontWeight.bold,
                                        color: CustomColor.white,
                                        size: 22,
                                      ),
                                      content: const CustomText(
                                        text:
                                            "Are you sure you want to delete this item?",
                                        size: 18,
                                      ),
                                      actions: <Widget>[
                                        //=============Cancel
                                        customButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            label: "CANCEL",
                                            labelColor: CustomColor.black,
                                            backgroundColor: CustomColor.green),
                                        //============Delete
                                        customButton(
                                            onPressed: () {
                                              deleteCustomer(widget.customerDetails);
                                              Navigator.popUntil(context,
                                                  (route) => route.isFirst);
                                            },
                                            backgroundColor: CustomColor.red,
                                            label: "DELETE",
                                            labelColor: CustomColor.black),
                                      ],
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColor.red,
                                foregroundColor: CustomColor.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                              ),
                              child:CustomText(
                                text: 'Delete',
                                ),
                            ),
                            SizedBox(width: 80,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColor.blue,
                                foregroundColor: CustomColor.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Customer(),
                                  ),
                                );
                              },
                              child: CustomText(
                                text: "   Edit   ",
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: CustomColor.green,
                                  foregroundColor: CustomColor.black,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 3,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Customer(),
                                    ),
                                  );
                                },
                                child: CustomText(
                                  text: "  Rent Out  ",
                                  color: CustomColor.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
