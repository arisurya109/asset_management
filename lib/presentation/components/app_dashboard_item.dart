import 'package:asset_management/core/core.dart';
import 'package:flutter/material.dart';

class AppDashboardItem extends StatelessWidget {
  final String icon;
  final String title;
  final String value;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  const AppDashboardItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.deviceWidth / 2 - 24,
      height: 90,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          AppAssetImg(icon, height: 32, width: 32, color: textColor),
          AppSpace.horizontal(8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
