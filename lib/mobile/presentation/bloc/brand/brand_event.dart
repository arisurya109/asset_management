part of 'brand_bloc.dart';

class BrandEvent extends Equatable {
  const BrandEvent();

  @override
  List<Object> get props => [];
}

class OnCreateAssetBrand extends BrandEvent {
  final AssetBrand params;

  const OnCreateAssetBrand(this.params);
}

class OnFindAssetBrandByQuery extends BrandEvent {
  final String params;

  const OnFindAssetBrandByQuery(this.params);
}

class OnClearAll extends BrandEvent {}
