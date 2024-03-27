// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_project/data_model/customer_db.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/collected_data.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class CustomerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      body: ValueListenableBuilder(
        valueListenable: customerNotifier,
        builder: (BuildContext ctx, List<CustomerDetailsModel> customerList,
            Widget? child) {
          if (customerList.isEmpty) {
            return Center(
              child: CustomText(
                text: "NO Customers added",
                size: 18,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: customerList.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 5,
                    ),
                    itemBuilder: (context, int index) {
                      final data = customerList[index];
                      return Padding(
                        padding: const EdgeInsets.all(1),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => CollectedData(),
                              ),
                            );
                          },
                          child: Card(
                            color: CustomColor.white,
                            elevation: 100,
                            child: SizedBox(
                              height: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //===============================Customer image
                                  Container(
                                    height: 120,
                                    width: 120,
                                    color: CustomColor.white,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                      ),
                                      child: Image.memory(

                                        File(data.CustomerImage)
                                            .readAsBytesSync(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      //=================================customerName
                                      children: [
                                        CustomText(
                                          text: data.customerName,
                                          color: CustomColor.black,
                                          size: 18,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        //================================LicenceNumber
                                        CustomText(
                                          text: data.licenceNumber,
                                          color: CustomColor.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        //==========================mobilNumber
                                        CustomText(
                                          text: data.mobilNumber,
                                          color: CustomColor.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        //===========================Drop of date
                                        CustomText(
                                          text: data.dropOffDate,
                                          color: CustomColor.red,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        //====================================
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
