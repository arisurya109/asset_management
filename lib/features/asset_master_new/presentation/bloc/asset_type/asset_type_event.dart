part of 'asset_type_bloc.dart';

class AssetTypeEvent extends Equatable {
  const AssetTypeEvent();

  @override
  List<Object> get props => [];
}

class OnCreateAssetType extends AssetTypeEvent {
  final AssetType params;

  const OnCreateAssetType(this.params);
}

class OnGetAllAssetType extends AssetTypeEvent {}

class OnUpdateAssetType extends AssetTypeEvent {
  final AssetType params;

  const OnUpdateAssetType(this.params);
}

class OnGetAssetTypeById extends AssetTypeEvent {
  final int params;

  const OnGetAssetTypeById(this.params);
}
