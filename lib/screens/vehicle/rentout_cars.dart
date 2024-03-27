import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_project/data_model/vehicle_db.dart';
import 'package:main_project/widgets/customcolors.dart';

class RentOutCars extends StatefulWidget {
  final VehicleDetailsModel? selectedCars;
  const RentOutCars({super.key, this.selectedCars});

  @override
  State<RentOutCars> createState() => _RentOutCarsState();
}

class _RentOutCarsState extends State<RentOutCars> {
  final nameController = TextEditingController();
  final mobController = TextEditingController();
  final licenseNumberController = TextEditingController();
  final emailController = TextEditingController();
  final dayCountController = TextEditingController();
  final meaterReadingController = TextEditingController();
  final advanceController = TextEditingController();
  String? carImage;
  File? imgPath;

  TimeOfDay timeOfDay = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    if (widget.selectedCars != null) {
      carImage = widget.selectedCars!.carimage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColor.primary,
    );
//         backgroundColor: CustomColor.primary,
//         body: ValueListenableBuilder<Box<CustomerDetailsModel>>(
//           valueListenable: Boxes.getcustomerdetail().listenable(),
//           builder: (context, box, _) {
//             var data = box.values.toList().cast<CustomerDetailsModel>();
//             if (data.isEmpty) {
//               return const Center(
//                 child: CustomText(
//                   text: 'NO RENTOUT CARS',
//                   size: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               );
//             } else {
//               print("hello");
//             }
            // } else {
            //   return ListView.builder(
            //     itemCount: data.length,
            //     itemBuilder: (context, index) {
            //       bool isLastItem = index == data.length - 1;
            //       return Padding(
            //         padding: EdgeInsets.only(
            //           bottom: isLastItem ? 75 : 0,
            //         ),
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Card(
            //             color: CustomColor.white,
            //             elevation: 5,
            //             child: SizedBox(
            //               height: 130,
            //               child: Row(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   GestureDetector(
            //                     onTap: () {
            //                       Navigator.of(context).push(
            //                         MaterialPageRoute(
            //                             builder: (ctx) =>
            //                                 CustomerData(customer: data[index])),
            //                       );
            //                     },
            //                     child: Padding(
            //                       padding: const EdgeInsets.all(8.0),
            //                       child: Container(
            //                         width: 170,
            //                         height: 130,
            //                         decoration: BoxDecoration(
            //                           borderRadius: BorderRadius.circular(10),
            //                           image: DecorationImage(
            //                             image: FileImage(
            //                               File(data[index].CustomerImage),
            //                             ),
            //                             fit: BoxFit.cover,
            //                           ),
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                   Expanded(
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.center,
            //                       children: [
            //                         Padding(
            //                           padding: const EdgeInsets.only(
            //                               top: 10, left: 30),
            //                           child: Text(data[index].customerName),
            //                         ),
            //                       ],
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           ),
            //         ),
            //       );
            //     },
//           },
//         ));
//   }
// }
// //       ),
// //     );
   }
}
