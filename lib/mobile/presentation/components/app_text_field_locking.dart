// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:asset_management/core/utils/colors.dart';

// ignore: must_be_immutable
class AppTextFieldLocking extends StatelessWidget {
  TextEditingController? controller;
  FocusNode? focusNode;
  String? hintText;
  bool? readOnly;
  void Function()? isLocked;
  double? fontSize;
  void Function(String)? onSubmitted;
  TextInputAction? textInputAction;

  AppTextFieldLocking({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.readOnly = false,
    this.isLocked,
    this.fontSize,
    this.onSubmitted,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      readOnly: readOnly!,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.kGrey),
        ),
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400),
        suffixIcon: isLocked != null
            ? IconButton(
                onPressed: isLocked,
                icon: Icon(readOnly! ? Icons.lock : Icons.lock_open_rounded),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: AppColors.kBase, width: 1),
        ),
      ),
    );
  }
}
