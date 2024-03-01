import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/add_vehicle.dart';
import 'package:main_project/screens/car_list.dart';
import 'package:main_project/screens/help&info.dart';
import 'package:main_project/screens/revenue.dart';
import 'package:main_project/screens/userdetails.dart';
import 'package:main_project/widgets/custom_list.dart';
import 'package:main_project/widgets/custom_text.dart';

class HomeScreen extends StatefulWidget {

 final String? selectedImage;

 const HomeScreen({Key? key, this.selectedImage}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserDetailsModel? _userDetails;
  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    final box = Boxes.getuser();
    final userDetails = box.get('details_db');
    setState(() {
      _userDetails = userDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    getVehicleDetails();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 29, 31),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.only(left: 100.0),
          child: CustomText(
            textContent: "Home",
            fontSize: 22,
            textColor: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                     CircleAvatar(
                      radius: 38,
                      backgroundColor: Colors.black,
                      backgroundImage: widget.selectedImage != null
                      ? FileImage(File(widget.selectedImage!))
                      : null,
                    ),
                    const SizedBox(height: 5),
                    if (_userDetails != null) ...[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            CustomText(
                              textContent: " ${_userDetails!.name}",
                              fontSize: 18,
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),                            
                            const SizedBox(height: 5),
                            CustomText(
                              textContent: " ${_userDetails!.mobile}",
                              fontSize: 18,
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            const SizedBox(height: 5),
                            CustomText(
                              textContent: " ${_userDetails!.email}",
                              fontSize: 18,
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              CustomList(
                leadingIcon: Icons.person_add,
                title: "User Details",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Userdetails(),
                    ),
                  );
                },
              ),
              CustomList(
                title: "Revenue",
                leadingIcon: Icons.currency_rupee,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Revenue(),
                    ),
                  );
                },
              ),
              CustomList(
                title: "Help & Info",
                leadingIcon: Icons.help_outline,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpAndInfo(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height -
              kToolbarHeight -
              MediaQuery.of(context).padding.top,
          child: const SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              VehicleList(), // Use VehicleList widget
            ]),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddVehicle(),
                ),
              );
            },
            child: const Text(
              "ADD CAR",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
