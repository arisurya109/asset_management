import 'package:flutter/material.dart';

import '../core.dart';

// ignore: must_be_immutable
class AppErrorWidget extends StatelessWidget {
  String message;

  AppErrorWidget(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.kGrey,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
