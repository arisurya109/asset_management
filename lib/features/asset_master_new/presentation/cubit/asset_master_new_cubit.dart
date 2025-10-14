import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_master_new/presentation/view/asset_type/asset_type_view.dart';
import 'package:asset_management/features/locations/presentation/view/location_view.dart';
import 'package:bloc/bloc.dart';

import '../view/asset_brand/asset_brand_view.dart';
import '../view/asset_category/asset_category_view.dart';
import '../view/asset_model/asset_model_view.dart';

class AssetMasterNewCubit extends Cubit<List<Map<String, dynamic>>> {
  AssetMasterNewCubit() : super([]);

  final List<Map<String, dynamic>> _items = [
    {
      'value': 'asset_type',
      'title': 'Asset Type',
      'icon': Assets.iAssetTypes,
      'view': AssetTypeView(),
    },
    {
      'value': 'asset_brand',
      'title': 'Asset Brand',
      'icon': Assets.iAssetBrand,
      'view': AssetBrandView(),
    },
    {
      'value': 'asset_category',
      'title': 'Asset Category',
      'icon': Assets.iAssetCategory,
      'view': AssetCategoryView(),
    },
    {
      'value': 'asset_model',
      'title': 'Asset Model',
      'icon': Assets.iAssetModel,
      'view': AssetModelView(),
    },
    {
      'value': 'location_view',
      'title': 'Location',
      'icon': Assets.iLocation,
      'view': LocationView(),
    },
  ];

  void load() {
    emit(_items);
  }
}
