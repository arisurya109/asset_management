part of 'asset_master_bloc.dart';

class AssetMasterEvent extends Equatable {
  const AssetMasterEvent();

  @override
  List<Object?> get props => [];
}

class OnInsertAssetMaster extends AssetMasterEvent {
  final AssetMaster params;

  const OnInsertAssetMaster(this.params);
}

class OnFindAllAssetMaster extends AssetMasterEvent {}

class OnUpdateAssetMaster extends AssetMasterEvent {
  final AssetMaster params;

  const OnUpdateAssetMaster(this.params);
}

class OnSelectedAssetMaster extends AssetMasterEvent {
  final AssetMaster params;

  const OnSelectedAssetMaster(this.params);
}
