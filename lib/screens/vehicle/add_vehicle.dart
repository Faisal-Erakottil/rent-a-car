// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/data_model/vehicle_db.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/pages/home_screen.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/custom_text_field.dart';
import 'package:main_project/widgets/customcolors.dart';

class AddVehicle extends StatefulWidget {
  final VehicleDetailsModel? vehicle;
  const AddVehicle({Key? key, this.vehicle}) : super(key: key);
  @override
  State<AddVehicle> createState() => AddVehicleState();
}

final vehiclenameController = TextEditingController();
final vehicleRegController = TextEditingController();
final vehicleRentController = TextEditingController();
File? imagepath;
String? selectedImage;
String? selectedFuel;
String? selectedSeat;
final formKey = GlobalKey<FormState>();

class AddVehicleState extends State<AddVehicle> {
  @override
  void initState() {
    super.initState();
    if (widget.vehicle != null) {
      vehiclenameController.text = widget.vehicle!.vehiclename;
      vehicleRegController.text = widget.vehicle!.vehiclereg;
      vehicleRentController.text = widget.vehicle!.rent;
      selectedFuel = widget.vehicle!.fueltype;
      selectedSeat = widget.vehicle!.seates;

      if (widget.vehicle!.carimage.isNotEmpty) {
        setState(() {
          imagepath = File(widget.vehicle!.carimage);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        title: const Padding(
          padding: EdgeInsets.all(85),
          child: CustomText(
            text: "Add Vehicle",
            size: 18,
          ),
        ),
        iconTheme: const IconThemeData(
          color: CustomColor.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
                bottom: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  pickImageFromGallery();
                },
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: Colors.blue),
                  ),
                  child: Stack(
                    children: [
                      if (imagepath != null && !kIsWeb)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            imagepath!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (imagepath != null && kIsWeb)
                        Image.network(
                          imagepath!.path,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      if (imagepath == null)
                        const Center(
                          child: CustomText(
                            text: " Add Image+",
                            size: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      const Positioned(
                        child: Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //===================================Add TextForms hear
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  //=====================================Vehicle name
                  CustomTextField(
                    controller: vehiclenameController,
                    labelText: "Car Name",
                    fieldName: "Car Name",
                    prefixIcon: Icons.directions_car_filled,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter vehicle Name";
                      }
                      return null;
                    },
                  ),
                  const Gap(10),
                  //=====================================Vehicle number
                  CustomTextField(
                    controller: vehicleRegController,
                    labelText: "Registeration Number",
                    fieldName: "Registeration Number",
                    prefixIcon: Icons.pin,
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Register Number';
                    }
                    return null;
                  },
                  ),

                  const Gap(10),
                  //=====================================vehicle color
                  customDropdownField(
                    labelText: "Fuel Type",
                    hintText: "Fuel Type",
                    value: selectedFuel,
                    items: [
                      'Petrol',
                      'Diesel',
                      'EV',
                      'CNG',
                      'Hybrid',
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        selectedFuel = value;
                      });
                    },
                    prefixIcon: const Icon(
                      Icons.local_gas_station_outlined,
                    ),
                  ),

                  const Gap(10),
                  //=====================================Vehicle Rent
                  customDropdownField(
                    labelText: "seates",
                    hintText: "seates",
                    value: selectedSeat,
                    items: [
                      '2 Seater',
                      '4 Seater',
                      '5 Seater',
                      '7 Seater',
                      '8 Seater',
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        selectedSeat = value;
                      });
                    },
                    prefixIcon: const Icon(
                      Icons.chair,
                    ),
                  ),

                  const Gap(10),
                  //======================================vehicle fuel type
                  CustomTextField(
                    controller: vehicleRentController,
                    labelText: " Rent/Day",
                    fieldName: "Rent/Day",
                    prefixIcon: Icons.currency_rupee,
                    keyboardType: TextInputType.number,
                     validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter rent of the vehicle";
                    }
                    return null;
                  },
                  ),

                  const Gap(10),
                  //=======================================Save Details
                  customButton(
                    onPressed: () {
                      saveDetails();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    label: "Save Details",
                    labelColor: CustomColor.white,
                    width: 150,
                    backgroundColor: CustomColor.blue,
                    icon: const Icon(Icons.save),
                  )
                  //============================================
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        imagepath = File(returnedImage.path);
        selectedImage = returnedImage.path;
      });
    }
  }

  Future<void> saveDetails() async {
    final vehicleName = vehiclenameController.text.trim();
    final vehicleReg = vehicleRegController.text.trim();
    final DailyRent = vehicleRentController.text.trim();

    // Validation
    if (imagepath == null ||
        vehicleName.isEmpty ||
        vehicleReg.isEmpty ||
        selectedFuel == null ||
        selectedSeat == null ||
        DailyRent.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomText(
            text: "Please fill out all fields",
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
      );
      return;
    }

    final cars = VehicleDetailsModel(
      vehiclename: vehicleName,
      vehiclereg: vehicleReg,
      fueltype: selectedFuel!,
      seates: selectedSeat!,
      rent: DailyRent,
      carimage: imagepath?.path ?? "",
    );

    // Save to database
    if (widget.vehicle == null) {
      addCar(cars);
    } else {
      int id = widget.vehicle?.id ?? -1;
    }
    // Clear text fields and reset state
    vehiclenameController.clear();
    vehicleRegController.clear();
    vehicleRentController.clear();
    setState(() {
      imagepath = null;
    });

    // Navigate back
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            updatedVehicle: cars,
          ),
        ));
  }
}
