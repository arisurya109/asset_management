import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_brand/asset_brand_export.dart';
import 'package:asset_management/features/asset_category/asset_category_export.dart';
import 'package:asset_management/features/asset_model/asset_model_export.dart';
import 'package:asset_management/features/asset_type/asset_type_export.dart';
import 'package:asset_management/features/assets/assets_export.dart';
import 'package:asset_management/features/location/location_export.dart';
import 'package:asset_management/features/vendor/vendor_export.dart';
import 'package:flutter/material.dart';

class MasterView extends StatelessWidget {
  const MasterView({super.key});

  @override
  Widget build(BuildContext context) {
    List masters = [
      {
        'title': 'Asset Type',
        'icon': Assets.iAssetTypes,
        'view': AssetTypeView(),
      },
      {
        'title': 'Asset Brand',
        'icon': Assets.iAssetBrand,
        'view': AssetBrandView(),
      },
      {
        'title': 'Asset Category',
        'icon': Assets.iAssetCategory,
        'view': AssetCategoryView(),
      },
      {
        'title': 'Asset Model',
        'icon': Assets.iAssetModel,
        'view': AssetModelView(),
      },
      {'title': 'Location', 'icon': Assets.iLocation, 'view': LocationView()},
      {'title': 'Vendor', 'icon': Assets.iVendor, 'view': VendorView()},
      {
        'title': 'Assets',
        'icon': Assets.iAssetManagement,
        'view': AssetsView(),
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          AppSpace.vertical(MediaQuery.of(context).viewPadding.top + 5),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: masters.length,
              itemBuilder: (context, index) {
                final master = masters[index];
                return ListTile(
                  onTap: () => context.push(master['view']),
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  title: Text(
                    master['title'],
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  leading: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: AppAssetImg(
                      master['icon'],
                      height: 28,
                      width: 28,
                      color: AppColors.kBlack,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
