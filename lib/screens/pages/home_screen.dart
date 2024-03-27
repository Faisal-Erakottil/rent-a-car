// ignore_for_file: non_constant_identifier_names, unused_field, prefer_const_constructors, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/user_model.dart';
import 'package:main_project/data_model/vehicle_db.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/vehicle/add_vehicle.dart';
import 'package:main_project/screens/vehicle/available_cars.dart';
import 'package:main_project/screens/pages/drawer_widget.dart';
import 'package:main_project/screens/vehicle/rentout_cars.dart';
import 'package:main_project/screens/pages/search_screen.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class HomeScreen extends StatefulWidget {
  final VehicleDetailsModel? updatedVehicle;
  const HomeScreen({Key? key, this.updatedVehicle}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VehicleDetailsModel? _VehicleList;
  UserDetailsModel? _userDetails;
  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    _fetchVehicleDetails();
  }

  Future<void> _fetchUserDetails() async {
    await getDetails();
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: CustomColor.primary,
        appBar: AppBar(
          backgroundColor: CustomColor.black,
          title: const Padding(
            padding: EdgeInsets.only(left: 106),
            child: CustomText(
              text: "Home",
              color: CustomColor.white,
              size: 20,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          //============================================search screen
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

          bottom: const TabBar(
              //=============================================Available cars tab
              tabs: [
                Tab(
                  child: CustomText(
                    text: "Available cars",
                    size: 18,
                  ),
                ),
                //==============================================Rent out cars tab
                Tab(
                  child: CustomText(
                    text: "Rent out cars",
                    size: 18,
                  ),
                ),
                //==============================================
              ],
              labelColor: CustomColor.white,
              indicatorColor: CustomColor.blue,
              unselectedLabelColor: CustomColor.white),
        ),
        //===============================================drawer widget
        drawer: CustomDrawer(userDetails: _userDetails),

        body: const TabBarView(children: [AvailableCars(), RentOutCars()]),
        bottomNavigationBar: PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: BottomAppBar(
            color: CustomColor.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    //===============================================Add Car button
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddVehicle(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const CustomText(
                        text: 'ADD CAR',
                        size: 20,
                        color: CustomColor.white,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
