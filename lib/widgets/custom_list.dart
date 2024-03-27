import 'package:flutter/material.dart';
import 'package:main_project/widgets/custom_text.dart';

class CustomList extends StatelessWidget {
  final String title;
  final IconData? leadingIcon;
  final VoidCallback? onTap;

  const CustomList({
    required this.title,
    this.leadingIcon,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadingIcon != null
          ? Icon(
              leadingIcon,
              color: Colors.blue,
            )
          : null,
      title: CustomText(
        text: title,
        color: Colors.blue,
      ),
      onTap: onTap,
    );
  }
}
