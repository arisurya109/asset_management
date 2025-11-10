import 'package:asset_management/domain/entities/user/user.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

class AppHeaderDrawer extends StatelessWidget {
  final bool isLarge;
  final User? user;

  const AppHeaderDrawer({super.key, this.user, required this.isLarge});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: AppColors.kBase,
        border: Border(bottom: BorderSide(color: AppColors.kBase)),
      ),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAssetImg(
              Assets.iAccount,
              height: isLarge ? 70 : 60,
              width: isLarge ? 70 : 60,
              color: AppColors.kWhite,
            ),
            AppSpace.vertical(12),
            Text(
              user?.name ?? '',
              style: TextStyle(
                fontSize: isLarge ? 18 : 16,
                color: AppColors.kWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
