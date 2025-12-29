// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppItemDrawer extends StatelessWidget {
  String title;
  final double fontSize;
  void Function()? onTap;

  AppItemDrawer({
    super.key,
    required this.title,
    this.onTap,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: fontSize),
      ),
      trailing: Icon(Icons.keyboard_arrow_right_outlined, size: fontSize + 10),
      onTap: onTap,
    );
  }
}
