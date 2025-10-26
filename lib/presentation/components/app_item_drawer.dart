// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppItemDrawer extends StatelessWidget {
  String title;
  void Function()? onTap;

  AppItemDrawer({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.keyboard_arrow_right_outlined, size: 28),
      onTap: onTap,
    );
  }
}
