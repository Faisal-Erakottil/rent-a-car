import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/vehicle_db.dart';
import 'package:main_project/screens/customer.dart';
import 'package:main_project/screens/vehicle/car_details.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class AvailableCars extends StatefulWidget {
  const AvailableCars({super.key});

  @override
  State<AvailableCars> createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      body: ValueListenableBuilder(
        valueListenable: Boxes.getvehicleData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<VehicleDetailsModel>();
          //=======================================================first Message
          if (data.isEmpty) {
            return const Center(
              child: CustomText(
                text: "NO CARS AVAILABLE",
                size: 18,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, int index) {
                bool isLastitem = index == data.length;
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: isLastitem ? 75 : 0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    //==============================================car details
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => cardetails(
                              vehicleModel: data[index],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        color: CustomColor.white,
                        elevation: 100,
                        child: SizedBox(
                          height: 225,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //========================================Reg Number
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      height: 30,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: CustomText(
                                          text: data[index].vehiclereg,
                                          size: 18,
                                          color: CustomColor.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //========================================Car Image
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 240,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(data[index].carimage),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //=========================================Car name
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: SizedBox(
                                      width: 200,
                                      height: 30,
                                      child: Text(
                                        data[index].vehiclename,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 26,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //==============================Rent now button
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 45.0, top: 5),
                                    child: SizedBox(
                                      width: 120,
                                      height: 35,
                                      child: customButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Customer(),
                                              ),
                                            );
                                          },
                                          label: "RENT NOW",
                                          labelColor: CustomColor.black,
                                          backgroundColor: CustomColor.green),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: SizedBox(
                                  width: 170,
                                  height: 25,
                                  child: Row(
                                    //=================================Fuel Type
                                    children: [
                                      const Icon(
                                        Icons.local_gas_station_outlined,
                                        color: CustomColor.blue,
                                      ),
                                      const Gap(2),
                                      CustomText(
                                        text: data[index].fueltype,
                                        color: CustomColor.black,
                                      ),
                                      const Gap(10),
                                    //==================================Rent/Day
                                      const Icon(
                                        Icons.currency_rupee,
                                        color: CustomColor.blue,
                                      ),
                                      CustomText(
                                        text: data[index].rent,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColor.black,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              //================================================
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
