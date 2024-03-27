import 'package:flutter/material.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class CollectedData extends StatefulWidget {
  

  const CollectedData({Key? key,}) : super(key: key);

  @override
  State<CollectedData> createState() => _CollectedDataState();
}

class _CollectedDataState extends State<CollectedData> {
  var vehiclenameController = TextEditingController();
  var vehicleRegController = TextEditingController();
  var dailyrentController = TextEditingController();
  String? selectedFuel;
  String? selectedSeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColor.black,
        title: const CustomText(
          text: "Customer Details", // Corrected typo
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: CustomColor.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 220,
            color: CustomColor.white,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // CustomText(
                //   text:
                //       "Vehicle Name: ${widget.combinedData.customerModel.customerName}",
                // ),
                // CustomText(
                //   text:
                //       "Vehicle Name: ${widget.combinedData.vehicleModel.vehiclename}",
                // ),
                // Add more widgets to display other details as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
