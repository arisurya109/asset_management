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
