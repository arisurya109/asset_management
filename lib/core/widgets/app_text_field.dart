import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppTextField extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  TextInputType? keyboardType;
  TextInputAction? textInputAction;

  AppTextField({
    super.key,
    this.hintText,
    this.textInputAction = TextInputAction.next,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.teal),
        ),
      ),
    );
  }
}
