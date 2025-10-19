part of 'asset_brand_bloc.dart';

class AssetBrandEvent extends Equatable {
  const AssetBrandEvent();

  @override
  List<Object> get props => [];
}

class OnGetAllAssetBrand extends AssetBrandEvent {}

class OnCreateAssetBrand extends AssetBrandEvent {
  final AssetBrand params;

  const OnCreateAssetBrand(this.params);
}
