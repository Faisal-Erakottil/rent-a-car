import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/customer_details.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      padding: const EdgeInsets.all(1),
                      child: Card(
                        color: CustomColor.white,
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
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
                              //===========================================Name
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
                                  //==============================Licence Number
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
                                  //==============================Mobile Number
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
                                  //=============================vehicle Number
                                  const Row(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                        width: 220,
                                        //color: CustomColor.red,
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const Gap(10),
                              //===========================================Edit
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
                                            builder: (context) =>
                                                CustomerDetails(
                                              Customer: data[index],
                                            ),
                                          ),
                                        ).then((data) {
                                          if(data != null){
                                            getAllCustomers();
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                  ),
                                  const Gap(50),
                                  SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.delete),
                                    ),
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
          }),
    );
  }
}
