import 'package:asset_management/core/core.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppNavbarItem extends StatelessWidget {
  void Function()? onTap;
  String label;
  String assets;
  bool? isSelected;

  AppNavbarItem({
    super.key,
    required this.onTap,
    required this.label,
    required this.assets,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
        child: Column(
          children: [
            Image.asset(assets, height: 24, width: 24),
            AppSpace.vertical(5),
            Text(
              label,
              style: TextStyle(
                color: isSelected == true ? AppColors.kBase : AppColors.kGrey,
                fontWeight: isSelected == true
                    ? FontWeight.w600
                    : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
