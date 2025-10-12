// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
part of 'asset_type_bloc.dart';

enum StatusAssetType { initial, loading, failed, success }

class AssetTypeState extends Equatable {
  StatusAssetType? status;
  List<AssetType>? assetTypes;
  AssetType? assetType;
  String? message;

  AssetTypeState({
    this.status = StatusAssetType.initial,
    this.assetTypes,
    this.assetType,
    this.message,
  });

  AssetTypeState copyWith({
    StatusAssetType? status,
    List<AssetType>? assetTypes,
    AssetType? assetType,
    String? message,
  }) {
    return AssetTypeState(
      status: status ?? this.status,
      assetTypes: assetTypes ?? this.assetTypes,
      assetType: assetType ?? this.assetType,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, assetTypes, assetType, message];
}
