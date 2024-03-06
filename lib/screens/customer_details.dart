// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/screens/home_screen.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/custom_text_field.dart';
import 'package:main_project/widgets/customcolors.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  var nameController = TextEditingController();
  var mobController = TextEditingController();
  var licenseNumberControler = TextEditingController();
  var emailController = TextEditingController();
  var dayCountController = TextEditingController();
  var meaterReadingController = TextEditingController();
  var advanceController = TextEditingController();
  File? imagepath;
  String? selectedImage;

  bool validateName = false;
  bool validateMobileNumber = false;
  bool validateLicenseNumber = false;
  bool validateEmail = false;
  bool validateDayCount = false;
  bool validateMeaterReading = false;
  bool validateadvance = false;

  //===function for selecting image
  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      setState(() {
        imagepath = File(returnedImage.path);
        selectedImage = returnedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 29, 31),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.all(86.0),
          child: CustomText(
            textContent: "Customer Details",
            textColor: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: CustomColor.white,
        ),
      ),
      //=============== image picker
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: pickImageFromGallery,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 85,
                    child: imagepath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(85),
                            child: Image.file(
                              imagepath!,
                              width: 170,
                              height: 170,
                              fit: BoxFit.cover,
                            ))
                        : const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                            size: 50,
                          ),
                  ),
                ),
              ),
              const Gap(10),
              Column(
                children: [
                  //================= Name field
                  textforms(
                      fieldname: "Name",
                      message: "Name is Empty",
                      controler: nameController,
                      validater: validateName,
                      keyboardType: TextInputType.text),
                  const Gap(10),
                  //================== Mobils Number
                  textforms(
                      fieldname: "Mobile Number",
                      message: "Mobile Number is Empty",
                      controler: mobController,
                      validater: validateMobileNumber,
                      keyboardType: TextInputType.phone),
                  const Gap(10),
                  //=====================LicenseNumber
                  textforms(
                    fieldname: "License Number",
                    message: "License Number is Empty",
                    controler: licenseNumberControler,
                    validater: validateLicenseNumber,
                  ),
                  const Gap(10),
                  //================== Email ID
                  textforms(
                    fieldname: "Email ID",
                    message: "Email ID is Empty",
                    controler: emailController,
                    validater: validateEmail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Gap(10),
                  //===================day count
                  textforms(
                    fieldname: "Number of days",
                    message: "Number of days is Empty",
                    controler: dayCountController,
                    validater: validateDayCount,
                    keyboardType: TextInputType.number,
                  ),
                  const Gap(10),
                  //=================== odomeater reading
                  textforms(
                    fieldname: "Odo Meater Reading",
                    message: "meater reading is Empty",
                    controler: meaterReadingController,
                    validater: validateMeaterReading,
                    keyboardType: TextInputType.number,
                  ),
                  const Gap(10),
                  //===================Advance amount
                  textforms(
                      fieldname: "Advance amount",
                      message: "Advance amount is Emty",
                      controler: advanceController,
                      validater: validateadvance,
                      keyboardType: TextInputType.number),
                  const Gap(10),
                  //================== save Button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      saveDetails();
                      setState(() {
                        nameController.text.isEmpty
                            ? validateName = true
                            : validateName = false;
                        mobController.text.isEmpty
                            ? validateMobileNumber = true
                            : validateMobileNumber = false;
                        licenseNumberControler.text.isEmpty
                            ? validateLicenseNumber = true
                            : validateLicenseNumber = false;
                        emailController.text.isEmpty
                            ? validateEmail = true
                            : validateEmail = false;
                        dayCountController.text.isEmpty
                            ? validateDayCount = true
                            : validateDayCount = false;
                        meaterReadingController.text.isEmpty
                            ? validateMeaterReading = false
                            : validateMeaterReading = true;
                        advanceController.text.isEmpty
                            ? validateDayCount
                            : validateadvance;
                        imagepath = null;
                      });
                      if (validateName == false &&
                          validateMobileNumber == false &&
                          validateEmail == false &&
                          validateLicenseNumber == false &&
                          validateDayCount == false &&
                          validateMeaterReading == false &&
                          validateadvance == false &&
                          selectedImage != null) {
                        CustomerDetailsModel(
                          customerName: nameController.text,
                          mobilNumber: mobController.text,
                          LicenceNumber: licenseNumberControler.text,
                          Email: emailController.text,
                          days: dayCountController.text,
                          reading: meaterReadingController.text,
                          advance: advanceController.text,
                          CustomerImage: imagepath?.path ?? "",
                        );
                      }

                      onAddSaveButtonClicked();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  //==================
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onAddSaveButtonClicked() async {
    final _name = nameController.text.trim();
    final _mobile = mobController.text.trim();
    final _LicenceNumber = licenseNumberControler.text.trim();
    final _email = emailController.text.trim();
    final _days = dayCountController.text.trim();
    final _reading = meaterReadingController.text.trim();
    final _advance = advanceController.text.trim();

    if (imagepath == null ||
        _name.isEmpty ||
        _mobile.isEmpty ||
        _LicenceNumber.isEmpty ||
        _email.isEmpty ||
        _days.isEmpty ||
        _reading.isEmpty ||
        _advance.isEmpty) {
      // Show error message or handle invalid input
      return;
    }
    final CustomerDetails = CustomerDetailsModel(
      customerName: _name,
      mobilNumber: _mobile,
      LicenceNumber: _LicenceNumber,
      Email: _email,
      days: _days,
      reading: _reading,
      advance: _advance,
      CustomerImage: imagepath?.path ?? "",
    );
    //  print(userDetails);
    // Pass the user details back to the previous screen (HomeScreen)
    Navigator.pop(context, CustomerDetails);
  }

  Future<void> saveDetails() async {
    onAddSaveButtonClicked();
    final name = nameController.text.trim();
    final mobile = mobController.text.trim();
    final LicenceNumber = licenseNumberControler.text.trim();
    final email = emailController.text.trim();
    final days = dayCountController.text.trim();
    final reading = meaterReadingController.text.trim();
    final advance = advanceController.text.trim();
    final image = imagepath?.path;

    // Save the input data to Hive
    final CustomerDetails = CustomerDetailsModel(
      customerName: name,
      mobilNumber: mobile,
      LicenceNumber: LicenceNumber,
      Email: email,
      days: days,
      reading: reading,
      advance: advance,
      CustomerImage: image!,
    );
    final box = Boxes.getcustomerdetails();
    box.put('customer_db', CustomerDetails);

    // Navigate back to the HomeScreen or perform any other action
    Navigator.pop(context);
  }
}