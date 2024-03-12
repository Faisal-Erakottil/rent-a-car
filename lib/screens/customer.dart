// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:main_project/data_model/box.dart';
import 'package:main_project/data_model/data_model.dart';
import 'package:main_project/db_functions/db_functions.dart';
import 'package:main_project/screens/customerList.dart';
import 'package:main_project/screens/customer_details.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class Customer extends StatefulWidget {
  const Customer({super.key});

  @override
  State<Customer> createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  CustomerDetailsModel? _customerDetailsModel;

  void initState() {
    getAllCustomers();
    super.initState();
    //_fetchCustomerDetails();
  }

  // Future<void> _fetchCustomerDetails() async {
  //   await getAllCustomers();
  //   final box = Boxes.getcustomerdetails();
  //   final CustomerDetails = box.get('customer_db');
  //   setState(() {
  //     _customerDetailsModel = CustomerDetails;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                final customerDetails = CustomerDetailsModel(
                  customerName: "",
                  mobilNumber: '',
                  LicenceNumber: '',
                  Email: '',
                  days: '',
                  reading: '',
                  advance: '',
                  CustomerImage: '',
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CustomerDetails(Customer: customerDetails),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      backgroundColor: CustomColor.primary,
      body: CustomerList(updatedCustumer: _customerDetailsModel),
    );
  }
}
