import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/screens/add_vehicle.dart';
import 'package:main_project/screens/customer.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class VehicleList extends StatelessWidget {
  final vehicleDetailsModel? updatedVehicle;
  const VehicleList({Key? key, this.updatedVehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      body: ValueListenableBuilder<Box<vehicleDetailsModel>>(
        valueListenable: Boxes.getvehicleData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<vehicleDetailsModel>();
          if (updatedVehicle != null) {
            int index =
                data.indexWhere((vehicle) => vehicle.id == updatedVehicle?.id);
            if (index != -1) {
              data[index] = updatedVehicle!;
            }
          }

          if (data.isEmpty) {
            return const Center(
              child: CustomText(
                textContent: "NO CARS AVAILABLE",
                fontSize: 18,
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
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      child: SizedBox(
                        height: 250,
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
                                      child: Text(
                                        data[index].vehiclereg,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //=================================Edit button
                                  SizedBox(
                                    width: 40,
                                    height: 50,
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddVehicle(
                                                vehicle: data[index]),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: CustomColor.black,
                                      ),
                                    ),
                                  ),
                                  //=========================================Delete
                                  SizedBox(
                                    height: 50,
                                    width: 30,
                                    //color: CustomColor.black,
                                    child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: CustomColor.primary,
                                              title: const CustomText(
                                                textContent: "Confirm",
                                                fontWeight: FontWeight.bold,
                                                textColor: CustomColor.white,
                                                fontSize: 22,
                                              ),
                                              content: const CustomText(
                                                textContent:
                                                    "Are you sure you want to delete this item?",
                                                fontSize: 18,
                                              ),
                                              actions: <Widget>[
                                                //=============Cancel
                                                customElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    label: "CANCEL",
                                                    labelColor:
                                                        CustomColor.black,
                                                    backgroundColor:
                                                        CustomColor.green),
                                                //============Delete
                                                customElevatedButton(
                                                    onPressed: () {
                                                      final box = Boxes
                                                          .getvehicleData();
                                                      box.delete(
                                                          data[index].key);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    backgroundColor:
                                                        CustomColor.red,
                                                    label: "DELETE",
                                                    labelColor:
                                                        CustomColor.black),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(Icons.delete),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            //========================================Car Image
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 250,
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
                                  padding:
                                      const EdgeInsets.only(left: 45.0, top: 5),
                                  child: SizedBox(
                                    width: 120,
                                    height: 35,
                                    child: customElevatedButton(
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
                                //================================on rent button
                                //  Padding(
                                //   padding:
                                //       const EdgeInsets.only(left: 45.0, top: 5),
                                //   child: SizedBox(
                                //     width: 120,
                                //     height: 35,
                                //     child: customElevatedButton(
                                //         onPressed: () {
                                //           Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //               builder: (context) => const Customer(),
                                //             ),
                                //           );
                                //         },
                                //         label: "ON RENT",
                                //         labelColor: CustomColor.black,
                                //         backgroundColor: CustomColor.red),
                                //   ),
                                // ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: SizedBox(
                                width: 170,
                                height: 25,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.local_gas_station_outlined,
                                      color: CustomColor.blue,
                                    ),
                                    const Gap(2),
                                    Text(
                                      data[index].fueltype,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Gap(10),
                                    const Icon(
                                      Icons.currency_rupee,
                                      color: CustomColor.blue,
                                    ),
                                    Text(
                                      data[index].rent,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            //==================================================
                          ],
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
