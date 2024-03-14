// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  int indexNum = 0;
  List<vehicleDetailsModel> searchCarResults = [];
  List<CustomerDetailsModel> searchCustomerResults = [];

  @override
  void initState() {
    super.initState();
    performSearch('');
  }

  void performSearch(String query) {
    setState(() {
      searchCarResults = searchCars(query);
      searchCustomerResults = searchCustomers(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        title: Padding(
          padding: const EdgeInsets.all(105.0),
          child: const CustomText(
            textContent: "Search",
            fontSize: 20,
          ),
        ),
        iconTheme: IconThemeData(color: CustomColor.white),
      ),
      body: Column(
        children: [
          const Gap(10),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) => performSearch(query),
              decoration: InputDecoration(
                labelText: 'Search',
                counterStyle: TextStyle(
                    decorationColor: const Color.fromARGB(255, 70, 220, 250)),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: CustomColor.white,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (var vehicle in searchCarResults)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  //===========================Available vehicles
                    child: ListTile(
                      selectedTileColor: CustomColor.primary,
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(vehicle.carimage)),
                        radius: 30,
                      ),
                      title: CustomText(
                        textContent: vehicle.vehiclename,
                        textColor: CustomColor.white,
                      ),
                      subtitle: CustomText(
                        textContent: '₹ ${vehicle.rent}/DAY',
                        textColor: CustomColor.white,
                      ),
                      trailing: SizedBox(
                        width: 28,
                        height: 65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: CustomColor.white,
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                for (var customer in searchCustomerResults)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  //================================available customers
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            FileImage(File(customer.CustomerImage)),
                        radius: 30,
                      ),

                      title: CustomText(
                        textContent: customer.customerName,
                        textColor: CustomColor.white,
                      ),
                      subtitle: CustomText(
                        textContent: customer.mobilNumber,
                        textColor: CustomColor.white,
                      ),
                      trailing: SizedBox(
                        width: 28,
                        height: 65,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: CustomColor.white,
                                  size: 15,
                                ),
                              ),
                            ]),
                      ),
                      onTap: () {},
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
