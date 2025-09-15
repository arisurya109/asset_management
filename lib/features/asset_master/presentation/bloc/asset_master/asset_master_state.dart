// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'asset_master_bloc.dart';

enum StatusAssetMaster { initial, loading, success, failed }

class AssetMasterState extends Equatable {
  StatusAssetMaster? status;
  List<AssetMaster>? assets;
  AssetMaster? asset;
  String? message;

  AssetMasterState({this.status, this.assets, this.asset, this.message});

  AssetMasterState copyWith({
    StatusAssetMaster? status,
    List<AssetMaster>? assets,
    AssetMaster? asset,
    String? message,
  }) {
    return AssetMasterState(
      status: status ?? this.status,
      assets: assets ?? this.assets,
      asset: asset ?? this.asset,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, assets, asset, message];
}
