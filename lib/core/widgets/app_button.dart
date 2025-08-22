// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  void Function()? onPressed;
  String? title;
  double? width;
  double? height;

  AppButton({
    super.key,
    this.height = 45,
    this.width = 200,
    this.onPressed,
    this.title = 'Title',
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
        fixedSize: Size(width!, height!),
      ),
      child: Text(
        title!,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
