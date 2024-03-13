// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/data_model.dart';
//import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/customer_details.dart';
import 'package:main_project/widgets/custom_button.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class CustomerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      body: ValueListenableBuilder<Box<CustomerDetailsModel>>(
        valueListenable: Boxes.getcustomerdetail().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<CustomerDetailsModel>();
          if (data.isEmpty) {
            return Center(
              child: CustomText(
                textContent: "NO Customers added",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
                    padding: const EdgeInsets.all(1),
                    child: Card(
                      color: CustomColor.white,
                      elevation: 100,
                      child: SizedBox(
                        height: 120,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //================================= Customer image
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                image: DecorationImage(
                                  image: FileImage(
                                    File(data[index].CustomerImage),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            //=====================================customerName
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width: 220,
                                      child: Text(
                                        data[index].customerName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //================================LicenceNumber
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width: 220,
                                      child: Text(
                                        data[index].LicenceNumber,
                                        style: const TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                //==================================mobilNumber
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width: 220,
                                      child: Text(
                                        data[index].mobilNumber,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Gap(10),
                            //======================================Edit button
                            Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CustomerDetails(
                                            customer: data[index],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                ),
                                const Gap(50),
                                //==============================Delete button
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: CustomColor.most,
                                            title: const CustomText(
                                              textContent: "Confirm",
                                              fontWeight: FontWeight.bold,
                                              textColor: CustomColor.white,
                                              fontSize: 22,
                                            ),
                                            content: const CustomText(
                                              textContent:
                                                  "Are you sure you want to delete this customer?",
                                              fontSize: 18,
                                            ),
                                            actions: <Widget>[
                                              customElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                label: "CANCEL",
                                                labelColor: CustomColor.black,
                                                backgroundColor: CustomColor.green,
                                              ),
                                              customElevatedButton(
                                                onPressed: () {
                                                  final box = Boxes.getcustomerdetail();
                                                  box.delete(data[index].key);
                                                  Navigator.of(context).pop();
                                                },
                                                backgroundColor: CustomColor.red,
                                                label: "DELETE",
                                                labelColor: CustomColor.black,
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                //==============================================
                                ),
                              ],
                            ),
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
