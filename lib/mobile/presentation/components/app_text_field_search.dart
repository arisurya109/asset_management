// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:asset_management/core/utils/colors.dart';

class AppTextFieldSearch extends StatelessWidget {
  TextEditingController? controller;
  FocusNode? focusNode;
  String? hintText;
  bool readOnly;
  bool isSearchActive;
  TextInputAction? textInputAction;
  TextInputType? keyboardType;
  void Function(String)? onSubmitted;
  void Function(String)? onChanged;
  void Function()? onClear;

  AppTextFieldSearch({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText = 'Find...',
    this.readOnly = false,
    this.isSearchActive = false,
    this.textInputAction,
    this.keyboardType,
    this.onSubmitted,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      focusNode: focusNode,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.kGrey),
        ),
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 13),
        prefixIcon: Icon(Icons.search),
        suffixIcon: isSearchActive
            ? IconButton(icon: const Icon(Icons.clear), onPressed: onClear)
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
