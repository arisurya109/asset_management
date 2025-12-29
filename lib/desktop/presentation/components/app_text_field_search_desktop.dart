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
        style: const TextStyle(fontSize: 12),
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 12,
            vertical: enabled == false ? 12 : 0,
          ),
          isDense: true,
          hintText: hintText,
          prefixIcon: withSearchIcon!
              ? const Icon(Icons.search, size: 16)
              : null,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
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
