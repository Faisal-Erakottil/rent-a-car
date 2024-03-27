// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/user_model.dart';
import 'package:main_project/screens/pages/home_screen.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/custom_text_field.dart';
import 'package:main_project/widgets/customcolors.dart';

class Userdetails extends StatefulWidget {
  //const Userdetails({super.key});
  const Userdetails({Key?key}): super(key: key);

  @override
  State<Userdetails> createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  var nameController = TextEditingController();
  var mobController = TextEditingController();
  var emailController = TextEditingController();
  File? imagepath;
  String? selectedImage;

  bool validateName = false;
  bool validateMobileNumber = false;
  bool validateEmail = false;

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
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        title: const Padding(
          padding: EdgeInsets.all(86.0),
          child: CustomText(
            text: "User Details",
            size: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: CustomColor.white,
        ),
      ),
      //=============== image picker
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImageFromGallery,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 70,
                  child: imagepath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.file(
                            imagepath!,
                            width: 140,
                            height: 140,
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
                  controller: nameController,
                  validater: validateName,
                  keyboardType: TextInputType.name,
                ),
                const Gap(20),
                //================== Mobils Number
                textforms(
                    fieldname: "Mobile Number",
                    message: "Mobile Number is Empty",
                    controller: mobController,
                    validater: validateMobileNumber,
                    keyboardType: TextInputType.phone),
                const Gap(20),
                //================== Email ID
                textforms(
                    fieldname: "Email ID",
                    message: "Email ID is Empty",
                    controller: emailController,
                    validater: validateEmail,
                    keyboardType: TextInputType.emailAddress),
                const Gap(20),
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
                      emailController.text.isEmpty
                          ? validateEmail = true
                          : validateEmail = false;
                      imagepath = null;
                    });
                    if (validateName == false &&
                        validateMobileNumber == false &&
                        validateEmail == false &&
                        selectedImage != null) {
                      UserDetailsModel(
                        name: nameController.text,
                        mobile: mobController.text,
                        email: emailController.text,
                        image: imagepath?.path ?? "",
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
                    color: CustomColor.white,
                  ),
                  label: const CustomText(
                    text: "Save",
                    size: 20,
                  ),
                ),
                //==================
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> onAddSaveButtonClicked() async {
    final _name = nameController.text.trim();
    final _mobile = mobController.text.trim();
    final _email = emailController.text.trim();
    if (imagepath == null ||
        _name.isEmpty ||
        _mobile.isEmpty ||
        _email.isEmpty) {
      return;
    }
    final userDetails = UserDetailsModel(
      name: _name,
      mobile: _mobile,
      email: _email,
      image: imagepath?.path ?? "",
    );
    //  print(userDetails);
    // Pass the user details back to the previous screen (HomeScreen)
    Navigator.pop(context, userDetails);
  }

  Future<void> saveDetails() async {
    onAddSaveButtonClicked();
    final name = nameController.text.trim();
    final mobile = mobController.text.trim();
    final email = emailController.text.trim();
    final image = imagepath?.path;

    // Save the input data to Hive
    final userDetails = UserDetailsModel(
      name: name,
      mobile: mobile,
      email: email,
      image: image!,
    );
    final box = Boxes.getuser();
    box.put('details_db', userDetails);

    // Navigate back to the HomeScreen or perform any other action
    Navigator.pop(context);
  }
}
