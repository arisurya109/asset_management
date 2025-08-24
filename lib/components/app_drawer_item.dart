import 'package:flutter/material.dart';

import '../core/widgets/app_asset_img.dart';
import '../core/widgets/app_space.dart';

// ignore: must_be_immutable
class AppDrawerItem extends StatelessWidget {
  String title;
  String icon;
  void Function()? onTap;
  bool isSelected;

  AppDrawerItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: isSelected ? Colors.teal : Colors.white,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          hoverColor: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(5),
          onTap: onTap,
          child: Container(
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppAssetImg(
                  icon,
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                ),
                AppSpace.horizontal(16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.5,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w500,
                    ),
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
