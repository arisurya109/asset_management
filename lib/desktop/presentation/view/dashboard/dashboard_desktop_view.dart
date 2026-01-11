import 'package:asset_management/core/core.dart';
import 'package:asset_management/desktop/presentation/components/app_body_desktop.dart';
import 'package:asset_management/desktop/presentation/components/app_header_desktop.dart';
import 'package:flutter/material.dart';

class DashboardDesktopView extends StatelessWidget {
  const DashboardDesktopView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppHeaderDesktop(title: 'Dashboard'),
        AppBodyDesktop(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 110,
                    width: (context.deviceWidth - 248) / 4.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.kWhite,
                      border: Border.all(color: AppColors.kGrey, width: 0.5),
                    ),
                  ),
                  Container(
                    height: 110,
                    width: (context.deviceWidth - 248) / 4.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.kWhite,
                      border: Border.all(color: AppColors.kGrey, width: 0.5),
                    ),
                  ),
                  Container(
                    height: 110,
                    width: (context.deviceWidth - 248) / 4.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.kWhite,
                      border: Border.all(color: AppColors.kGrey, width: 0.5),
                    ),
                  ),
                  Container(
                    height: 110,
                    width: (context.deviceWidth - 248) / 4.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.kWhite,
                      border: Border.all(color: AppColors.kGrey, width: 0.5),
                    ),
                  ),
                ],
              ),
              AppSpace.vertical(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 250,
                    width: (context.deviceWidth - 248) / 2.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.kWhite,
                      border: Border.all(color: AppColors.kGrey, width: 0.5),
                    ),
                  ),
                  Container(
                    height: 250,
                    width: (context.deviceWidth - 248) / 2.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.kWhite,
                      border: Border.all(color: AppColors.kGrey, width: 0.5),
                    ),
                  ),
                ],
              ),
              AppSpace.vertical(24),
              Expanded(
                child: Container(
                  width: (context.deviceWidth - 248),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: AppColors.kWhite,
                    border: Border.all(color: AppColors.kGrey, width: 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
