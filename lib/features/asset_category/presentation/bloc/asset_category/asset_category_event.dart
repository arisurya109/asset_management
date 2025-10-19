part of 'asset_category_bloc.dart';

class AssetCategoryEvent extends Equatable {
  const AssetCategoryEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllAssetCategory extends AssetCategoryEvent {}

class OnCreateAssetCategory extends AssetCategoryEvent {
  final AssetCategory params;

  const OnCreateAssetCategory(this.params);
}
