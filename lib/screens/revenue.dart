import 'package:flutter/material.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class Revenue extends StatefulWidget {
  const Revenue({super.key});

  @override
  State<Revenue> createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 29, 31),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Padding(
          padding: EdgeInsets.only(left: 100),
          child: CustomText(
            textContent: "Revenue",
            textColor: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
         iconTheme: const IconThemeData(
          color: CustomColor.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Today"),
            ),
            //const Gap(5),
            ElevatedButton(
              onPressed: () {},
              child: const Text("This Week"),
            ),
            //const Gap(5),
            ElevatedButton(
              onPressed: () {},
              child: const Text("This Month"),
            ),
          ],
        ),
      ),
    );
  }
}
