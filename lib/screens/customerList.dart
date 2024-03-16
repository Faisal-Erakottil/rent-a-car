// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';
import 'package:main_project/widgets/delete_alert.dart';
import 'package:main_project/widgets/edit_alert.dart';

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
                textContent: "NO Customers added",
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [ ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: customerList.length,
                  separatorBuilder: (BuildContext context,int index) =>
                  const SizedBox(height: 5,),
                  itemBuilder: (context, int index) {
                    final data = customerList[index];
                    return Padding(
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
                              SizedBox(
                                height: 120,
                                width: 120,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                  ),
                                  child: Image.memory(
                                    File(data.CustomerImage).readAsBytesSync(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                                
                              const SizedBox(width: 10,),
                              //=====================================customerName
                                
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      textContent: data.customerName,
                                      textColor: CustomColor.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    //================================LicenceNumber
                                    CustomText(
                                      textContent: data.LicenceNumber,
                                      textColor: CustomColor.black,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    //==================================mobilNumber
                                    CustomText(
                                      textContent: data.mobilNumber,
                                      textColor: CustomColor.black,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                               Spacer(),
                              //======================================Edit button
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (data.id != null) {
                                        editAlert(
                                            context, data.id!, customerList, index);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: CustomColor.black,
                                    ),
                                  ),
                                  const SizedBox(height: 50),
                                  //==============================Delete button
                                  GestureDetector(
                                    onTap: () {
                                      if (data.id != null) {
                                        deleteAlert(context, data.id!);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: CustomColor.black,
                                    ),
                                  ),
                                  //==============================================
                                ],
                              ),
                            ],
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

  editAlert(BuildContext context, int id,
      List<CustomerDetailsModel> customerList, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return EditAlert(onEdit: () {
            Navigator.of(context).pop();
            //Navigator.of(Context).push(MaterialPageRout(
            //  builder:(context)=>
            //  EditCustomer(CustomerDetailsModel:customerList[index])));
          });
        });
  }

  deleteAlert(BuildContext context, int id) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteAlert(onDelete: () {
            deleteCustomer(id);
            Navigator.of(context).pop();
          });
        });
  }
}
