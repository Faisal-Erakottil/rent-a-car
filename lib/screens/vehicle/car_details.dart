// ignore: file_names
// ignore_for_file: use_super_parameters

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/vehicle_db.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/vehicle/update_vehicle.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

// ignore: camel_case_types
class cardetails extends StatefulWidget {
  final VehicleDetailsModel vehicleModel;

  const cardetails({Key? key, required this.vehicleModel}) : super(key: key);

  @override
  State<cardetails> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<cardetails> {
  var vehiclenameController = TextEditingController();
  var vehicleRegController = TextEditingController();
  var dailyrentController = TextEditingController();
  File? imagepath;
  String? selectedImage;
  String? selectedFuel;
  String? selectedSeat;

  Widget _buildSelectedImage() {
    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 520,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 30,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          //==========================================================Car Image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: widget.vehicleModel.carimage.isNotEmpty
                ? Image.file(
                    File(widget.vehicleModel.carimage),
                    fit: BoxFit.cover,
                    width: 420,
                    height: 220,
                  )
                : Container(),
          ),
          //===================================================================
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        centerTitle: true,
        title: const CustomText(
          text: "CAR DETAILS",
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: CustomColor.black,
        iconTheme: const IconThemeData(color: CustomColor.white),
      ),
      body: ValueListenableBuilder<Box<VehicleDetailsModel>>(
          valueListenable: Boxes.getvehicleData().listenable(),
          builder: (context, box, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child:_buildSelectedImage(), 
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 300,
                    height: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //=====================================Vehicle Name
                            children: [
                              const CustomText(
                                text: 'Name',
                                fontWeight: FontWeight.w600,
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.vehicleModel.vehiclename,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //======================================vehicle Reg
                            children: [
                              const CustomText(
                                text: "REG number",
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.vehicleModel.vehiclereg,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //========================================Fuel Type
                            children: [
                              const CustomText(
                                text: "Fuel",
                                fontWeight: FontWeight.w600,
                                color: CustomColor.blue,
                              ),
                              CustomText(
                                text: widget.vehicleModel.fueltype,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //==================================seat Count
                              const CustomText(
                                text: "Seater",
                                color: CustomColor.blue,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText(
                                text: widget.vehicleModel.seates,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //================================vehicle Rent
                              const CustomText(
                                text: "Daily Rent",
                                color: CustomColor.blue,
                                fontWeight: FontWeight.w600,
                              ),
                              CustomText(
                                text: widget.vehicleModel.rent,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //================================== DELETE button
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
                                              deletVehicle(widget.vehicleModel);
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
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                              ),
                              child: const Text('DELETE'),
                            ),
                            const Gap(10),
                            //====================================update button
                            ElevatedButton(
                              onPressed: () {
                                editCar(
                                  widget.vehicleModel,
                                  widget.vehicleModel.vehiclename.toString(),
                                  widget.vehicleModel.vehiclereg.toString(),
                                  widget.vehicleModel.fueltype.toString(),
                                  widget.vehicleModel.seates.toString(),
                                  widget.vehicleModel.rent.toString(),
                                  widget.vehicleModel.carimage.toString(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: CustomColor.green,
                                foregroundColor: CustomColor.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 3,
                              ),
                              child: const Text('UPDATE'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future<void> editCar(
    VehicleDetailsModel vehiclemodel,
    String vehicleName,
    String vehicleReg,
    String fuelType,
    String seates,
    String rent,
    String carImage,
  ) async {
    vehiclenameController.text = vehicleName;
    vehicleRegController.text = vehicleReg;
    dailyrentController.text = rent;
    selectedSeat = seates;
    selectedFuel = fuelType;
    selectedImage = carImage;
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UpdateVehicle(
        vehicleModel: vehiclemodel,
      ),
    ));
  }
}
