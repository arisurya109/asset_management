import 'package:asset_management/domain/entities/user/user.dart';
import 'package:flutter/material.dart';

import '../../core/core.dart';

class AppHeaderDrawer extends StatelessWidget {
  final User user;

  const AppHeaderDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: AppColors.kBase,
        border: Border(bottom: BorderSide(color: AppColors.kBase)),
      ),
      child: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppAssetImg(
                Assets.iAccount,
                height: 80,
                width: 80,
                color: AppColors.kWhite,
              ),
              AppSpace.vertical(12),
              Text(
                user.name ?? '',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.kWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
