// ignore_for_file: non_constant_identifier_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/custom_text_field.dart';
import 'package:main_project/screens/home_screen.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({super.key});
  @override
  State<AddVehicle> createState() => AddVehicleState();
}

class AddVehicleState extends State<AddVehicle> {
  final vehiclenameController = TextEditingController();
final vehicleRegController = TextEditingController();
final vehicleRentController = TextEditingController();

File? imagepath;
String? selectedImage;
String? selectedFuel;
String? selectedSeat;
final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 29, 31),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.all(70),
          child: CustomText(
            textContent: "Add Vehicle",
            fontSize: 18,
            textColor: Colors.white,
          ),
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
                      if (imagepath != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            imagepath!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      if (imagepath == null)
                        const Center(
                          child: CustomText(
                            textContent: " Add Image+",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.black,
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
                    hintText: "Car Name",
                    prefixIcon: Icons.directions_car_filled,
                    keyboardType: TextInputType.name,
                  ),

                  const Gap(10),
                  //=====================================Vehicle number
                  CustomTextField(
                    controller: vehicleRegController,
                    labelText: "Registeration Number",
                    hintText: "Registeration Number",
                    prefixIcon: Icons.pin,
                    keyboardType: TextInputType.streetAddress,
                  ),
                  const Gap(10),
                  //=====================================vehicle color
                  customDropdownField(
                    labelText: "Fuel Type",
                    hintText: "Fuel Type",
                    value: selectedFuel,
                    items: ['Petrol', 'Diesel', 'EV', 'CNG', 'Hybrid'],
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
                    hintText: "Rent/Day",
                    prefixIcon: Icons.currency_rupee,
                    keyboardType: TextInputType.number,
                  ),
                  const Gap(10),
                  //=======================================Save Details
                  customElevatedButton(
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
    if (imagepath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: CustomText(
            textContent: "Pleas select an image",
            textColor: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
      );
      return;
    }
    if (vehicleName.isEmpty ||
        vehicleReg.isEmpty ||
        selectedFuel == null ||
        selectedSeat == null ||
        DailyRent.isEmpty) {
      return;
    }
    final cars = vehicleDetailsModel(
      vehiclename: vehicleName,
      vehiclereg: vehicleReg,
      fueltype: selectedFuel!,
      seates: selectedSeat!,
      rent: DailyRent,
      image: imagepath?.path ?? "",
    );
    addCar(cars);
    Navigator.pop(context);
    vehiclenameController.clear();
    vehicleRegController.clear();
    vehicleRentController.clear();
    setState(() {
      imagepath = null;
    });
  }
}
