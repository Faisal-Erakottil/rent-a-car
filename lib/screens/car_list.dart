import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/widgets/custom_text.dart';

class VehicleList extends StatefulWidget {
  const VehicleList({super.key});

  @override
  State<VehicleList> createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
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
                bool isLastitem = index == data.length - 1;
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
                                height: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: FileImage(
                                      File(data[index].image),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, left: 30),
                                  child: Text(
                                    data[index].vehiclename,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                               
                              ],
                            ))
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
