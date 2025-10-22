import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../features/asset_category/asset_category_export.dart';
import '../../features/asset_model/asset_model_export.dart';
import '../../features/assets/assets_export.dart';
import '../../features/location/location_export.dart';
import 'app_dashboard_item.dart';

class AppDashboard extends StatelessWidget {
  const AppDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Dashboard',
          style: TextStyle(
            color: AppColors.kBlack,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppSpace.vertical(12),
        SizedBox(
          height: context.deviceHeight * 0.26,
          child: Column(
            children: [
              SizedBox(
                height: context.deviceHeight * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<AssetModelBloc, AssetModelState>(
                      builder: (context, state) {
                        return AppDashboardItem(
                          asset: Assets.iAssetModel,
                          colorBorder: AppColors.kWhite,
                          colorCard: AppColors.kBase,
                          colorContent: AppColors.kWhite,
                          value: state.assets?.length.toString() ?? '',
                          description: 'Asset Model',
                        );
                      },
                    ),
                    BlocBuilder<AssetCategoryBloc, AssetCategoryState>(
                      builder: (context, state) {
                        return AppDashboardItem(
                          asset: Assets.iAssetCategory,
                          colorBorder: AppColors.kBase,
                          colorCard: AppColors.kWhite,
                          colorContent: AppColors.kBase,
                          value: state.category?.length.toString() ?? '',
                          description: 'Asset Category',
                        );
                      },
                    ),
                  ],
                ),
              ),
              AppSpace.vertical(16),
              SizedBox(
                height: context.deviceHeight * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<AssetsBloc, AssetsState>(
                      builder: (context, state) {
                        return AppDashboardItem(
                          asset: Assets.iAssetMaster,
                          colorBorder: AppColors.kBase,
                          colorCard: AppColors.kWhite,
                          colorContent: AppColors.kBase,
                          value: state.assets?.length.toString() ?? '',
                          description: 'Total Assets',
                        );
                      },
                    ),
                    BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) {
                        return AppDashboardItem(
                          asset: Assets.iLocation,
                          colorBorder: AppColors.kWhite,
                          colorCard: AppColors.kBase,
                          colorContent: AppColors.kWhite,
                          value: state.locations?.length.toString() ?? '',
                          description: 'Total Location',
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
