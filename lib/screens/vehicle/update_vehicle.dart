// ignore_for_file: must_call_super, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/data_model/vehicle_db.dart';
import 'package:main_project/screens/vehicle/add_vehicle.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/custom_text_field.dart';
import 'package:main_project/widgets/customcolors.dart';

class UpdateVehicle extends StatefulWidget {
  final VehicleDetailsModel vehicleModel;
  const UpdateVehicle({super.key, required this.vehicleModel});

  @override
  State<UpdateVehicle> createState() => _UpdateVehicleState();
}

class _UpdateVehicleState extends State<UpdateVehicle> {
  var vehiclenameController = TextEditingController();
  var vehicleRegController = TextEditingController();
  var vehicleRentController = TextEditingController();
  File? imagepath;
  String? selectedImage;
  String? selectedFuel;
  String? selectedSeat;

  @override
  void initState() {
    super.initState();
    vehiclenameController = TextEditingController();
    vehicleRegController = TextEditingController();
    vehicleRentController = TextEditingController();
    imagepath = null;
    selectedImage = null;
    selectedFuel = null;
    selectedSeat = null;

    vehiclenameController.text = widget.vehicleModel.vehiclename;
    vehicleRegController.text = widget.vehicleModel.vehiclereg;
    vehicleRentController.text = widget.vehicleModel.rent;
    selectedSeat = widget.vehicleModel.seates;
    selectedFuel = widget.vehicleModel.fueltype;
    selectedImage = widget.vehicleModel.carimage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        centerTitle: true,
        title: const CustomText(
          text: 'Update vehicle',
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: CustomColor.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
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
                //=====================================Vehicle name
                CustomTextField(
                  controller: vehiclenameController,
                  labelText: "Car Name",
                  fieldName: "Car Name",
                  prefixIcon: Icons.directions_car_filled,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.characters,
                ),
                const Gap(10),
                //=====================================Vehicle number
                CustomTextField(
                  controller: vehicleRegController,
                  labelText: "Registeration Number",
                  fieldName: "Registeration Number",
                  prefixIcon: Icons.pin,
                  keyboardType: TextInputType.streetAddress,
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
                ),
                const Gap(10),
                //=====================================Edit Image
                customButton(
                  backgroundColor: CustomColor.blue,
                  labelColor: CustomColor.black,
                  onPressed: pickImageFromGallery,
                  label: 'Add Image',
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //============================================Update Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: CustomColor.blue,
                        fixedSize: const Size(300, 30),
                      ),
                      onPressed: () async {
                        widget.vehicleModel.vehiclename =
                            vehiclenameController.text;

                        widget.vehicleModel.vehiclereg =
                            vehicleRegController.text;

                        widget.vehicleModel.rent = vehicleRentController.text;

                        widget.vehicleModel.seates = selectedSeat ?? "";

                        widget.vehicleModel.fueltype = selectedFuel ?? "";
                        
                        widget.vehicleModel.carimage = selectedImage ?? "";
                        await widget.vehicleModel.save();
                        Navigator.pop(context);
                      },
                      child: const CustomText(
                        text: 'UPDATE',
                        color: CustomColor.black,
                      ),
                    ),
                  ],
                )
                //============================================
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
        selectedImage = returnedImage.path;
      });
    }
  }
}
