part of 'asset_category_bloc.dart';

class AssetCategoryEvent extends Equatable {
  const AssetCategoryEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllAssetCategory extends AssetCategoryEvent {}

class OnGetAssetCategoryById extends AssetCategoryEvent {
  final int params;

  const OnGetAssetCategoryById(this.params);
}

class OnCreateAssetCategory extends AssetCategoryEvent {
  final AssetCategory params;

  const OnCreateAssetCategory(this.params);
}

class OnUpdateAssetCategory extends AssetCategoryEvent {
  final AssetCategory params;

  const OnUpdateAssetCategory(this.params);
}
