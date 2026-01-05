// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/core.dart';

// ignore: must_be_immutable
class AppTextFieldSearchDesktop extends StatelessWidget {
  final double? width;
  final double? height;
  final TextEditingController? controller;
  final void Function(String)? onSubmitted;
  final String? hintText;
  Widget? suffixIcon;
  void Function(String)? onChanged;
  final bool? enabled;
  final bool? withSearchIcon;
  final FocusNode? focusNode;

  AppTextFieldSearchDesktop({
    super.key,
    this.width = 240,
    this.height = 32,
    this.controller,
    this.onSubmitted,
    this.hintText,
    this.suffixIcon,
    this.onChanged,
    this.enabled = true,
    this.withSearchIcon = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        enabled: enabled,
        style: TextStyle(
          fontSize: 12,
          color: enabled == false ? AppColors.kGrey : null,
          fontWeight: enabled! ? FontWeight.w500 : FontWeight.w400,
        ),
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: enabled == false ? 12 : 0,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: AppColors.kGrey),
          ),
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          prefixIcon: withSearchIcon!
              ? const Icon(Icons.search, size: 16)
              : null,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.kBlack, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.kBlack, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: AppColors.kBase, width: 1),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
