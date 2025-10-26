import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/presentation/components/app_dashboard_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../bloc/master/master_bloc.dart';

class AppDashboardContent extends StatelessWidget {
  const AppDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpace.vertical(16),
        Text(
          'Dashboard',
          style: TextStyle(
            color: AppColors.kBlack,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppSpace.vertical(12),
        BlocBuilder<MasterBloc, MasterState>(
          builder: (context, state) {
            return Wrap(
              direction: Axis.horizontal,
              runSpacing: 16,
              spacing: 16,
              children: [
                AppDashboardItem(
                  backgroundColor: AppColors.kBase,
                  borderColor: AppColors.kGrey,
                  icon: Assets.iAssetModel,
                  textColor: AppColors.kWhite,
                  title: 'Model',
                  value: state.models?.length.toString() ?? '',
                ),
                AppDashboardItem(
                  backgroundColor: AppColors.kWhite,
                  borderColor: AppColors.kBase,
                  icon: Assets.iAssetCategory,
                  textColor: AppColors.kBase,
                  title: 'Category',
                  value: state.categories?.length.toString() ?? '',
                ),
                AppDashboardItem(
                  backgroundColor: AppColors.kWhite,
                  borderColor: AppColors.kBase,
                  icon: Assets.iLocation,
                  textColor: AppColors.kBase,
                  title: 'Location',
                  value: state.locations?.length.toString() ?? '',
                ),
                AppDashboardItem(
                  backgroundColor: AppColors.kBase,
                  borderColor: AppColors.kGrey,
                  icon: Assets.iAssetModel,
                  textColor: AppColors.kWhite,
                  title: 'Brand',
                  value: state.brands?.length.toString() ?? '',
                ),
                BlocBuilder<AssetBloc, AssetState>(
                  builder: (context, state) {
                    final totalQuantity = state.assets?.fold<int>(
                      0,
                      (previousValue, asset) =>
                          previousValue + (asset.quantity ?? 0),
                    );

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppDashboardItem(
                          icon: Assets.iAssetMaster,
                          title: 'Quantity',
                          value: totalQuantity?.toString() ?? '',
                          backgroundColor: AppColors.kBase,
                          borderColor: AppColors.kGrey,
                          textColor: AppColors.kWhite,
                        ),
                        AppDashboardItem(
                          icon: Assets.iAssetMaster,
                          title: 'Assets',
                          value: state.assets?.length.toString() ?? '',
                          backgroundColor: AppColors.kWhite,
                          borderColor: AppColors.kBase,
                          textColor: AppColors.kBase,
                        ),
                      ],
                    );
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
