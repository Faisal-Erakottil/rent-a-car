// ignore_for_file: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        title: const Padding(
          padding: EdgeInsets.only(left:80.0),
          child: CustomText(
            textContent: 'Customer List',
            textColor: CustomColor.white,
            fontSize: 18,
          ),
        ),
        iconTheme: const IconThemeData(color: CustomColor.white),
      ),
      backgroundColor: CustomColor.primary,
      body: ValueListenableBuilder<Box<CustomerDetailsModel>>(
          valueListenable: Boxes.getcustomerdetails().listenable(),
          builder: (context, box, _) {
            var data = box.values.toList().cast<CustomerDetailsModel>();
            if (data.isEmpty) {
              return const Center(
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
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //=============================== Customer image
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left:2, top: 10),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        //color: CustomColor.green
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: FileImage(
                                              File(data[index].CustomerImage),
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //=================================Customer name
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        height: 30,
                                        child: Text(
                                          data[index].customerName,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      //==========================Licence Number
                                      SizedBox(
                                        width: 150,
                                        height: 30,
                                        child: Text(
                                          data[index].LicenceNumber,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                      //===========================Mobile Number
                                      SizedBox(
                                        height: 30,
                                        width: 150,
                                        child: SizedBox(
                                          width: 150,
                                          height: 30,
                                          child: Text(
                                            data[index].mobilNumber,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
          }),
    );
  }
}
