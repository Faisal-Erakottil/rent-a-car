import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/screens/add_vehicle.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class VehicleList extends StatelessWidget {
  const VehicleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: ValueListenableBuilder<Box<vehicleDetailsModel>>(
        valueListenable: Boxes.getvehicleData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<vehicleDetailsModel>();
          if (data.isEmpty) {
            return const Center(
              child: CustomText(
                  textContent: "NO CARS AVAILABLE",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
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
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      color: Colors.white70,
                      elevation: 5,
                      child: SizedBox(
                        height: 130,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: 170,
                                height: 200,
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
                            ),
                            //============================Edit button
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AddVehicle(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: CustomColor.green,
                              ),
                            ),
                            //==============================Delete button
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("Confirm"),
                                      content: const Text(
                                          "Are you sure you want to delete this item?"),
                                      actions: <Widget>[
                                        //=============Cancel
                                        TextButton(
                                          onPressed: () {
                                            // Close the dialog
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("CANCEL"),
                                        ),
                                        //============Delete
                                        TextButton(
                                          onPressed: () {
                                            // Delete the item from the box
                                            final box = Boxes.getvehicleData();
                                            box.delete(data[index].key);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("DELETE"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            //==============================
                            Expanded(
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: Text(
                                          data[index].vehiclename,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
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
