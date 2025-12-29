import 'package:flutter/material.dart';

import '../../../core/core.dart';

// ignore: must_be_immutable
class AppDrawerDesktop extends StatelessWidget {
  bool isSelected;
  String title;
  void Function()? onTap;

  AppDrawerDesktop({
    super.key,
    this.isSelected = false,
    this.title = 'Title',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(5),
      color: isSelected ? AppColors.kBase : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        child: Container(
          width: context.deviceWidth,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? AppColors.kWhite : AppColors.kGrey,
            ),
          ),
        ),
      ),
    );
  }
}
