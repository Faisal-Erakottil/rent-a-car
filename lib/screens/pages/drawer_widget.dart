import 'dart:io';
import 'package:flutter/material.dart';
import 'package:main_project/data_model/user_model.dart';
import 'package:main_project/screens/customer.dart';
import 'package:main_project/screens/pages/help&info.dart';
import 'package:main_project/screens/revenue.dart';
import 'package:main_project/screens/userdetails.dart';
import 'package:main_project/widgets/custom_list.dart';
import 'package:main_project/widgets/custom_text.dart';
import 'package:main_project/widgets/customcolors.dart';

class CustomDrawer extends StatelessWidget {
  final UserDetailsModel? userDetails;

  const CustomDrawer({Key? key, this.userDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: CustomColor.white,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color:CustomColor.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundImage:
                        userDetails != null && userDetails!.image.isNotEmpty
                            ? FileImage(File(userDetails!.image))
                            : null,
                  ),
                  const SizedBox(height: 5),
                  if (userDetails != null) ...[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          CustomText(
                            text: "Name: ${userDetails!.name}",
                            size: 18,
                            color: CustomColor.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                            text: "Mob No: ${userDetails!.mobile}",
                            size: 18,
                            color: CustomColor.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 5),
                          CustomText(
                            text: "Email Id: ${userDetails!.email}",
                            size: 18,
                            color:CustomColor.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 5),
                ],
              ),
            ),
            CustomList(
              leadingIcon: Icons.person_add,
              title: "User Details",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Userdetails(),
                  ),
                );
              },
            ),
            CustomList(
              leadingIcon: Icons.person_add,
              title: "Customer List",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Customer(),
                  ),
                );
              },
            ),
            CustomList(
              title: "Revenue",
              leadingIcon: Icons.currency_rupee,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Revenue(),
                  ),
                );
              },
            ),
            CustomList(
              title: "Help & Info",
              leadingIcon: Icons.help_outline,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HelpAndInfo(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
