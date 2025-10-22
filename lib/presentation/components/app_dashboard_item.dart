import 'package:asset_management/core/core.dart';
import 'package:flutter/material.dart';

class AppDashboardItem extends StatelessWidget {
  final Color colorCard;
  final Color colorBorder;
  final String value;
  final String description;
  final Color colorContent;
  final String asset;
  const AppDashboardItem({
    super.key,
    required this.colorCard,
    required this.value,
    required this.description,
    required this.colorContent,
    required this.asset,
    required this.colorBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16),
      width: (context.deviceWidth / 2) - 32,
      decoration: BoxDecoration(
        color: colorCard,
        border: Border.all(color: colorBorder, width: 0.7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppAssetImg(asset, height: 28, width: 28, color: colorContent),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: colorContent,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                AppSpace.vertical(3),
                Text(
                  description,
                  style: TextStyle(
                    color: colorContent,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
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
