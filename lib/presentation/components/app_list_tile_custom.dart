import 'package:flutter/material.dart';

import '../../core/core.dart';

// ignore: must_be_immutable
class AppListTileCustom extends StatelessWidget {
  void Function()? onTap;
  String? title;
  String? trailing;
  double? fontSize;

  AppListTileCustom({
    super.key,
    this.onTap,
    this.title,
    this.trailing,
    this.fontSize = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.kWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: AppColors.kBase),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title ?? 'Title',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  trailing ?? 'Trailing',
                  style: TextStyle(
                    color: AppColors.kBase,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
