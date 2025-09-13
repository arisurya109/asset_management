// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  String title;
  void Function()? onPressed;
  double width;
  double height;
  Color? backgroundColor;
  Color? titleColor;

  AppButton({
    super.key,
    this.title = 'Title',
    this.onPressed,
    this.width = 150,
    this.height = 45,
    this.backgroundColor = Colors.teal,
    this.titleColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: Size(width, height),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: titleColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
