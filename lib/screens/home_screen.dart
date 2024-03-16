// ignore_for_file: non_constant_identifier_names, unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/add_vehicle.dart';
import 'package:main_project/screens/car_list.dart';
import 'package:main_project/screens/drawer_widget.dart';
import 'package:main_project/screens/search_screen.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class HomeScreen extends StatefulWidget {
  final vehicleDetailsModel? updatedVehicle;
  const HomeScreen({Key? key, this.updatedVehicle}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  vehicleDetailsModel? _VehicleList;
  UserDetailsModel? _userDetails;
  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    _fetchVehicleDetails();
  }

  Future<void> _fetchUserDetails() async {
    final box = Boxes.getuser();
    final userDetails = box.get('details_db');
    setState(() {
      _userDetails = userDetails;
    });
  }

  Future<void> _fetchVehicleDetails() async {
    await getVehicleDetails();
    final box = Boxes.getvehicleData();
    final VehicleList = box.get('vehicle_db');
    setState(() {
      _VehicleList = VehicleList;
    });
  }

  @override
  Widget build(BuildContext context) {
    getVehicleDetails();
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        title: const Padding(
          padding: EdgeInsets.only(left: 106),
          child: CustomText(
            textContent: "Home",
            textColor: CustomColor.white,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              },
              icon: Icon(Icons.search))
        ],
      ),
      drawer: CustomDrawer(userDetails: _userDetails),
      body: Column(children: [
        Expanded(
          child: VehicleList(),
        ),
        //=====================================Add Car button
        customElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddVehicle(),
                  ));
            },
            label: "ADD CAR",
            labelColor: CustomColor.white,
            backgroundColor: CustomColor.blue),
      ]),
    );
  }
}
