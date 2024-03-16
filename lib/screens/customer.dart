// ignore_for_file: file_names, non_constant_identifier_names, unused_field, unused_import, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/customerList.dart';
import 'package:main_project/screens/customer_details.dart';
import 'package:main_project/screens/search_screen.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class Customer extends StatefulWidget {
  final CustomerDetailsModel? updatedcustomer;
  const Customer({Key? key, this.updatedcustomer}) : super(key: key);

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  @override
  Widget build(BuildContext context) {
    getCustomerDetails();
  
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        backgroundColor: CustomColor.black,
        title: const Padding(
          padding: EdgeInsets.only(left: 75),
          child: CustomText(
            textContent: "Customer List",
            textColor: CustomColor.white,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: Icon(Icons.search)),
        
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomerDetails(),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: CustomerList(),
    );
  }
}
